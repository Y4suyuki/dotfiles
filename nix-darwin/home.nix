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
    };

    shellAbbrs = {
      gs = "git status";
      gd = "git diff";
      gg = "git log --oneline --graph --all --decorate";
    };

    interactiveShellInit = ''
      set -x TERM xterm-256color
      fish_add_path $HOME/.local/bin
      fish_vi_key_bindings
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
}
