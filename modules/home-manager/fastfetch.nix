{ config, pkgs, ... }:

{
# Adapted from https://github.com/dacrab/fastfetch-config/blob/main/config.jsonc
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "none";
        #source = "nixos";
      };

      modules = [

        # ───────────── Hardware ─────────────

        {
          type = "custom";
          format = "╭───────────────────────── Hardware ──────────────────────────╮";
          outputColor = "blue";
        }

        {
          type = "title";
          key = " PC";
          keyColor = "green";
        }

        {
          type = "host";
          key = "│ ├󰇅 Laptop";
          keyColor = "green";
        }

        {
          type = "display";
          key = "│ ├󰍹 Display";
          keyColor = "green";
        }

        {
          type = "cpu";
          key = "│ ├󰍛 CPU";
          showPeCoreCount = true;
          format = "{1}";
          keyColor = "green";
        }

        {
          type = "gpu";
          key = "│ ├󰍛 GPU";
          keyColor = "green";
        }

        {
          type = "memory";
          key = "└ └󰍛 Memory";
          keyColor = "green";
        }

        {
          type = "custom";
          format = "╰─────────────────────────────────────────────────────────────╯";
          outputColor = "blue";
        }

        # ───────────── Software ─────────────

        {
          type = "custom";
          format = "╭───────────────────────── Software ──────────────────────────╮";
          outputColor = "blue";
        }

        {
          type = "os";
          key = " OS";
          keyColor = "cyan";
        }

        {
          type = "kernel";
          key = "│ ├ Kernel";
          keyColor = "cyan";
        }

        {
          type = "packages";
          key = "│ ├󰏖 Packages";
          keyColor = "cyan";
        }

        {
          type = "shell";
          key = "│ ├ Shell";
          keyColor = "cyan";
        }

        {
          type = "terminal";
          key = "│ ├ Terminal";
          keyColor = "cyan";
        }

        {
          type = "command";
          key = "│ ├ OS Age";
          keyColor = "cyan";
          text = ''
            birth_install=$(stat -c %W /)
            current=$(date +%s)
            time_progression=$((current - birth_install))
            days_difference=$((time_progression / 86400))
            echo $days_difference days
          '';
        }

        {
          type = "uptime";
          key = "└ └ Uptime";
          keyColor = "cyan";
        }

        {
          type = "de";
          key = " DE";
          keyColor = "blue";
        }

        {
          type = "wm";
          key = " WM";
          keyColor = "magenta";
        }

        {
          type = "gpu";
          key = "│ ├󰍛 GPU Driver";
          format = "{3}";
          keyColor = "magenta";
        }

        {
          type = "brightness";
          key = "│ ├󰃟 Brightness";
          keyColor = "magenta";
        }

        {
          type = "version";
          key = "└ └ FastFetch";
          keyColor = "magenta";
        }

        {
          type = "custom";
          format = "╰────────────────────────────────────────────────────────────╯";
          outputColor = "blue";
        }

        #{
        #  type = "custom";
	#  format = ''
	#	  {#0} {#1} {#2} {#3} {#4} {#5} {#6} {#7}
	#	  '';
	#} #for some reason dont work
	{
	  type = "colors";
	  symbol = "diamond";
	}

        "break"
      ];
    };
  };
}
