{ cosense-cli, i-have-adhd }:
{
  programs.agent-skills = {
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

    skills.enable = [
      "cosense"
      "i-have-adhd"
    ];

    # `symlink-tree` uses rsync --delete and would take over ~/.cursor/skills.
    # `link` only adds the selected skill via home.file, so existing skills stay.
    targets.cursor = {
      enable = true;
      dest = ".cursor/skills";
      structure = "link";
    };
  };
}
