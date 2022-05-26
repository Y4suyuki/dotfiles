set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x EDITOR nvim

set -x VIMCONFIG ~/.config/nvim
set -x VIMDATA ~/.local/share/nvim
# set -x GOPATH ~/.local/go

set -a PATH $GOPATH/bin
fish_add_path $HOME/.cargo/bin

abbr vi nvim
abbr e 'emacs -nw'
abbr r ranger
abbr tf terraform

abbr ef 'nvim ~/.config/fish/config.fish'
abbr sf 'source ~/.config/fish/config.fish'

abbr gg 'git log --oneline --graph --all --decorate'
abbr gs 'git status'
abbr ga 'git add'
abbr gd 'git diff'

if status --is-interactive
  eval (/opt/homebrew/bin/brew shellenv)
end

source ~/.asdf/asdf.fish
starship init fish | source

fish_vi_key_bindings
