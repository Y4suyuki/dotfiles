{
  description = "HERP codex darwin system";

  inputs = {
    codex.url = "github:herp-inc-hq/codex";
  };

  outputs = inputs@{ self, codex }:
  {
    darwinConfigurations."GTPC25021" = codex.inputs.nix-darwin.lib.darwinSystem {
      modules = [
        codex.darwinModules.default
        ({ lib, pkgs, ... }: {
          codex.standardPackages.enable = true;

          # enable nix in zsh and bash
          programs.bash.enable = true;
          programs.zsh.enable = true;

          programs.fish.enable = true;

          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";

          # guard against macOS update check breakage
          system.activationScripts.checks.text = "";

          users.knownUsers = ["y4suyuki"];
          users.users.y4suyuki = {
            uid = 501;
            shell = pkgs.fish;
          };
        })
      ];
    };
  };
}
