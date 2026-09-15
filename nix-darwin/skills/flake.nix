{
  description = "Pinned Agent Skills catalog";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
    cosense-cli = {
      url = "github:helpfeel/cosense-cli";
      flake = false;
    };
    i-have-adhd = {
      url = "github:ayghri/i-have-adhd";
      flake = false;
    };
  };

  outputs =
    { agent-skills, cosense-cli, i-have-adhd, ... }:
    {
      homeManagerModules.default = {
        imports = [
          agent-skills.homeManagerModules.default
          (import ./home-manager.nix { inherit cosense-cli i-have-adhd; })
        ];
      };
    };
}
