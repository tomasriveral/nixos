{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    initContent = ''
# Safe cat that uses colorize plugin ccat
custom-cat() {
  if [[ -t 1 ]]; then
    ccat "$@"
  else
    command cat "$@"
  fi
}

    fastfetch\n''
    ;
    shellAliases = {
	".." = "z ..";
	grep = "rg";
	ll = "ls -alF";
	la = "ls -A";
	l = "ls -CF";
	ls = "ls -hA -s --color";
	cat = "custom-cat";
};
  };
}
