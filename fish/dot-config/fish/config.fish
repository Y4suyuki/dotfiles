set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE ja_JP.UTF-8

set -x XMODIFIERS @im=fcitx

set -x TERMINAL alacritty
set -x EDITOR vim
# set -x PAGER most

set -x VIMCONFIG ~/.config/nvim
set -x VIMDATA ~/.local/share/nvim

set -x TIUPPATH $HOME/.tiup

fish_add_path $HOME/.cargo/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.pulumi/bin
fish_add_path -g ~/.poetry/bin
fish_add_path -g $TIUPPATH/bin

abbr vi nvim
abbr d docker
abbr p pacman
abbr r ranger
abbr t terraform
abbr tf terraform
abbr la 'eza -l --icons --git -a'
abbr y yazi

abbr ef 'nvim ~/.config/fish/config.fish'
abbr sf 'source ~/.config/fish/config.fish'

abbr gg 'git log --oneline --graph --all --decorate'
abbr gs 'git status'
abbr ga 'git add'
abbr gd 'git diff'

alias ls 'eza --icons --git'
alias e 'emacs'
alias v 'nvim'
alias ec 'emacsclient'

#if status --is-interactive
#  eval (/opt/homebrew/bin/brew shellenv)
#end

if test -z (pgrep ssh-agent | string collect)
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end
fish_vi_key_bindings

bind -M insert \cp _fish_ai_codify_or_explain
bind -M default \cp _fish_ai_codify_or_explain
bind -M insert \ca _fish_ai_autocomplete_or_fix
bind -M insert \ca _fish_ai_autocomplete_or_fix

source ~/.asdf/asdf.fish
starship init fish | source

# set -Ua fish_user_paths "$HOME/.rye/shims"

direnv hook fish | source
zoxide init fish | source

# pnpm
set -gx PNPM_HOME "/home/y4suyuki/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
