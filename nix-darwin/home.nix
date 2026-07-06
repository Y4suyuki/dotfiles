{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Minimal fish config — aliases, abbrs, and prompt tools.
  # (No home.packages yet — those come later to avoid collisions with codex.)
  programs.fish = {
    enable = true;

    shellAliases = {
      v = "nvim";
      e = "emacs";
      k = "kubectl";
      ls = "eza --icons --git";
      ca = "cursor-agent";
      c = "cursor";
    };

    shellAbbrs = {
      gs = "git status";
      gd = "git diff";
      gg = "git log --oneline --graph --all --decorate";
      enix = "v ~/gh/y4suyuki/dotfiles/nix-darwin/flake.nix";
      rnix = "sudo darwin-rebuild switch --flake ~/gh/y4suyuki/dotfiles/nix-darwin#GTPC25021";
    };

    interactiveShellInit = ''
      set -x TERM xterm-256color
      fish_add_path $HOME/.local/bin
      fish_add_path /usr/local/sessionmanagerplugin/bin
      fish_add_path /opt/homebrew/bin
      fish_vi_key_bindings
      bass source (codex configure bash | psub)
      starship init fish | source
      zoxide init fish | source
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      credential = {
        helper = [
          ""
          "!gh auth git-credential"
        ];
      };
      alias = {
        co = "checkout";
        pl = "pull";
      };
    };
    includes = [
      {
        condition = "gitdir:~/gh/";
        contents = {
          user = {
            name = "Yasuyuki Ageishi";
            email = "y4suyuki@protonmail.com";
          };
        };
      }
      {
        condition = "gitdir:~/gh/herp-inc-hq/";
        contents = {
          user = {
            name = "Yasuyuki Ageishi";
            email = "yasuyuki.ageishi@herp.co.jp";
          };
        };
      }
    ];
    
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    nmap
    rustscan
    atool
    emacs
    eza
    fd
    ffmpeg
    fishPlugins.done
    fishPlugins.bass
    fzf
    gitui
    gnupg
    go
    gopls
    google-cloud-sdk
    htop
    istioctl
    libuchardet
    texlive.combined.scheme-full
    pass
    pandoc
    nodejs
    mermaid-cli
    pnpm
    ripgrep
    imagemagick
    ssm-session-manager-plugin
    starship
    stow
    s3fs
    tree
    terraform-ls
    uv
    whisper-cpp
    yazi
    yq
    weechat
    zola
    zoxide
    mariadb.client
    yamlfmt
  ];
}
