{ cosense-cli, i-have-adhd, cursor-plugins }:
{
  programs.agent-skills = {
    sources.pstack = {
      path = cursor-plugins;
      subdir = "pstack/skills";
      filter.maxDepth = 1;
    };

    sources.cosense-cli = {
      path = cosense-cli;
      subdir = "skills";
      filter.maxDepth = 1;
    };

    sources.i-have-adhd = {
      path = i-have-adhd;
      subdir = "skills";
      filter.maxDepth = 1;
    };

    sources.local = {
      path = ./local;
      subdir = "skills";
      filter.maxDepth = 1;
    };

    skills.enable = [
      "cosense"
      "i-have-adhd"
      "pr-brief"
      "y4suyuki-mode"
    ];

    skills.enableAll = [ "pstack" ];

    # `symlink-tree` uses rsync --delete and would take over ~/.cursor/skills.
    # `link` only adds the selected skill via home.file, so existing skills stay.
    targets.cursor = {
      enable = true;
      dest = ".cursor/skills";
      structure = "link";
    };

    targets.claude = {
      enable = true;
      dest = ".claude/skills";
      structure = "link";
    };
  };
}
