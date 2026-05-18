_: {
  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "jonathan";
    plugins = [
      "aliases"
      "alias-finder"
      "colored-man-pages"
      "colorize"
      "command-not-found"
      "dirhistory"
      "fzf"
      "git"
      "rclone"
      "safe-paste"
      "sudo"
    ];
  };
}
