# used for the terminal autostart. Needs to get cleared and recall fastfetch so that the bar from oh-my-zsh get resized
{writeShellApplication, ...}:
writeShellApplication {
  name = "custom-performance";
  runtimeInputs = [
    "hyprland"
    "gawk"
    "libnotify"
  ];
  text = ''
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] ; then
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword animation borderangle,0; \
            keyword decoration:shadow:enabled 0;\
            keyword decoration:blur:enabled 0;\
    	    keyword decoration:fullscreen_opacity 1;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        notify-send -u critical -t 5000 "Performance mode [ON]"
        exit
    else
        notify-send -u critical -t 5000 "Performance mode [OFF]"
        hyprctl reload
        exit 0
    fi
  '';
}
