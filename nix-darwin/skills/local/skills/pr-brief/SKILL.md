---
name: pr-brief
description: GitHub PR を人間のレビュアーが最速で理解できるよう、意図・Before・変更方針・読む順番のブリーフィングを作り、hunk 上に説明注釈を付けて開く。レビュー指摘は理解フェーズの後に、変更の塊に紐づけて出す。「/pr-brief 123」「この PR をブリーフィングして」などで使う。
---

# PR Brief

人間のレビュアーが **PR の意図 → 変更前のコード → 変更方針 → 実際の差分** の順に理解できるよう支援する。
このスキルは 2 フェーズに分かれる。**フェーズ 1 では評価・指摘を一切しない。** 指摘はユーザーが明示的に求めたときだけフェーズ 2 で出す。

## 入力

- PR 番号・`owner/repo#123`・PR URL のいずれか
- 番号のみの場合、カレントディレクトリの origin からリポジトリを推定する

## フェーズ 1: ブリーフィング

### 1. 情報収集

```bash
gh pr view <PR> --json number,title,body,author,baseRefName,headRefName,url,commits,files,closingIssuesReferences
gh pr diff <PR>
```

- `closingIssuesReferences` や本文中の issue リンクがあれば `gh issue view` で読む
- コミットメッセージも意図の手がかりとして読む
- **Before を説明するため、変更対象の周辺コードを base ブランチ側で読む。** ローカルに checkout がある場合は `git show origin/<base>:<path>` を使う。ない場合は `gh api repos/{owner}/{repo}/contents/<path>?ref=<base>` を使う
- 変更された関数の呼び出し元・呼び出し先も必要な範囲で読む。ただし目的は Before の説明であり、網羅的な調査はしない

### 2. ブリーフィングを出力する

以下のフォーマットで、**1〜3 分で読める分量** に収める。推測で埋めた部分は「（推測）」と明記する。

```markdown
# PR #<n>: <title>

## 意図
何の問題を解決するのか / 何を実現したいのか。2〜3 文。

## Before
変更前、関連するコードがどう動いていたか。主要な関数・型・データの流れ・呼び出し関係。
意図に対して「何が足りなかったか / 何が問題だったか」が分かるように書く。

## 変更方針
意図を実現するための変更を 3〜5 個の論理的な塊に分ける。
- **塊 1: <名前>** — 何をどう変えたか（対象ファイル）
- **塊 2: <名前>** — ...

## 読む順番
ファイル名順ではなく、理解しやすい順に並べる。原則は 型・スキーマ → コアロジック → 呼び出し側 → テスト。
1. `path/to/types.ts` (塊 1)
2. ...

## 流し読みでよい部分
rename・フォーマット変更・生成物・lockfile・スナップショットなど。
```

### 3. hunk に説明注釈を付けて開く

各塊の説明を、該当 hunk の注釈として `brief.json` に書き出す。
注釈は **why の説明** であり、評価ではない。「塊 N: 元は〜だったのを〜のために〜に変えている」の形で書く。

```json
{
  "version": 1,
  "summary": "<意図を 1 文で>",
  "files": [
    {
      "path": "src/foo.ts",
      "summary": "塊 1: <このファイルでの役割>",
      "annotations": [
        {
          "newRange": [10, 24],
          "summary": "塊 1: <何をしているか>",
          "rationale": "<Before と比べて何が変わり、なぜ必要か>",
          "author": "brief"
        }
      ]
    }
  ]
}
```

- `files` の並びは「読む順番」に合わせる
- 行番号は PR の新側（head）の行番号。`gh pr diff` の hunk ヘッダ `@@ -a,b +c,d @@` から正確に計算する
- 流し読みでよいファイルには注釈を付けず、file の `summary` に「機械的変更」とだけ書く

一時ディレクトリに書き出し、ユーザーに次のコマンドを提示する（エージェント自身は TUI を起動しない）。

```bash
hunk gh <PR> -- --agent-context /tmp/pr-brief/<n>/brief.json
```

hunk がすでに開いている場合は、`hunk session list` でセッションを確認する。そのうえで `hunk session comment apply --stdin` で同じ内容をライブセッションに流し込んでもよい（hunk-review スキルの手順に従う）。

ここで止まり、ユーザーが読み終えるのを待つ。

## フェーズ 2: レビュー（ユーザーが求めたときのみ）

- 指摘は **フェーズ 1 の塊に紐づけて** 出す。形式は「塊 2 / `src/foo.ts:42` — 指摘内容」
- 重要度を付ける: `must`（マージ前に要修正）/ `should`（直した方がよい）/ `nit`（好み）
- 塊に属さない横断的な指摘（設計・テスト不足など）は最後にまとめる
- hunk のライブセッションがあれば、指摘を `hunk session comment apply` で注釈として追加する

## フェーズ 3: GitHub への投稿（ユーザーが求めたときのみ）

1. `hunk session comment list --json` で、ユーザーが `c` で書いたメモと残すと指示されたエージェントの指摘を集める
2. PR の pending review として登録する。**submit はしない。**

```bash
gh api repos/{owner}/{repo}/pulls/<n>/reviews --method POST --input - <<'EOF'
{
  "commit_id": "<head sha>",
  "comments": [
    { "path": "src/foo.ts", "line": 42, "side": "RIGHT", "body": "..." }
  ]
}
EOF
```

- `event` を指定しないことで pending のまま残る
- 投稿前に、投稿するコメントの一覧をユーザーに見せて確認を取る
- 投稿後は PR URL を返し、GitHub 上で見直してから Approve / Request changes するよう伝える

## 原則

- フェーズ 1 では評価語（「良い」「問題」「懸念」）を使わない。理解の材料だけを渡す
- 分からないことは推測で埋めずに「不明」と書く。ユーザーはそれ自体をレビュー観点にできる
- 差分全体を説明し直さない。ユーザーは差分を hunk で直接読むので、説明は意図と対応関係に絞る
