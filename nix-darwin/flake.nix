{
  description = "HERP codex darwin system";

  inputs = {
    codex.url = "github:herp-inc-hq/codex/release-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "codex/nixpkgs";
  };

  outputs = inputs@{ self, codex, home-manager }:
  {
    darwinConfigurations."GTPC25021" = codex.inputs.nix-darwin.lib.darwinSystem {
      modules = [
        codex.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.y4suyuki = {
            imports = [
              codex.homeModules.default
            ];
            home.stateVersion = "25.11";
          };
          home-manager.backupFileExtension = "backup";
        }
        ({ lib, pkgs, ... }: {
          codex.standardPackages.enable = true;

          # enable nix in zsh and bash
          programs.bash.enable = true;
          programs.zsh.enable = true;

          programs.fish.enable = true;

          system.stateVersion = 6;
          system.primaryUser = "y4suyuki";

          nixpkgs.hostPlatform = "aarch64-darwin";

          nixpkgs.config.allowUnfree = true;

          # macOS system defaults
          system.defaults.trackpad.Clicking = true;
          system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
          system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
          system.defaults.NSGlobalDomain.KeyRepeat = 1;

          # fonts
          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.droid-sans-mono
            nerd-fonts.hack
            nerd-fonts.symbols-only
          ];

          # guard against macOS update check breakage
          system.activationScripts.checks.text = "";

          users.knownUsers = ["y4suyuki"];
          users.users.y4suyuki = {
            uid = 501;
            shell = pkgs.fish;
            name = "y4suyuki";
            home = "/Users/y4suyuki";
          };
        })
      ];
    };
  };
}
