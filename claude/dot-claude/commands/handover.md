Create a session handover document at `handover-{branch-name}.md` in the project root so another Claude Code session can seamlessly continue the work. The branch name is derived from the current git branch (e.g., branch `y4suyuki/dup-177` becomes `handover-y4suyuki-dup-177.md`, with `/` replaced by `-`).

## Steps

1. **Analyze the current session** - Review the full conversation history to understand what was worked on.

2. **Check git state** - Run `git status`, `git diff --stat`, and `git log --oneline -10` to capture the current state of the codebase. Use the current branch name for the filename.

3. **Write `handover-{branch-name}.md`** with the following sections:

### Required sections

```markdown
# Session Handover

## Date
<current date and time>

## Branch
<current git branch>

## Summary
<2-3 sentence overview of what this session was about>

## What Was Done
<bulleted list of completed work items with file paths>

## What's In Progress
<bulleted list of work that was started but not finished, with enough detail to continue>

## What's Left To Do
<bulleted list of remaining tasks, ordered by priority>

## Key Decisions Made
<important architectural or design decisions made during this session and their rationale>

## Current State
<description of the current state - does it build? are tests passing? any known issues?>

## Files Changed
<list of modified/added/deleted files from git status>

## Relevant Context
<any important context the next session needs - API docs consulted, external references, gotchas discovered, etc.>

## How To Continue
<step-by-step instructions for the next session to pick up where this one left off>
```

4. **Notify the user** that the handover file has been created and suggest they start the next session with: "Read handover-{branch-name}.md and continue the work described there."
