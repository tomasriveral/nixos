{...}: {
  # a minimal ly config as the big config (ly.nix) didnt worked
  services.displayManager.ly = {
    enable = true;
    settings = {
      # Core animation
      animation = "none"; # none or doom or matrix or gameoflife or a dur file
      # Ly supports 24-bit true color with styling, which means each color is a 32-bit value.
      # The format is 0xSSRRGGBB, where SS is the styling, RR is red, GG is green, and BB is blue.
      # Here are the possible styling options:
      # TB_BOLD      0x01000000
      # TB_UNDERLINE 0x02000000
      # TB_REVERSE   0x04000000
      # TB_ITALIC    0x08000000
      # TB_BLINK     0x10000000
      # TB_HI_BLACK  0x20000000
      # TB_BRIGHT    0x40000000
      # TB_DIM       0x80000000
      # Programmatically, you'd apply them using the bitwise OR operator (|), but because Ly's
      # configuration doesn't support using it, you have to manually compute the color value.
      # Note that, if you want to use the default color value of the terminal, you can use the
      # special value 0x00000000. This means that, if you want to use black, you *must* use
      # the styling option TB_HI_BLACK (the RGB values are ignored when using this option).
      # Basic TUI settings
      clear_password = true;
      default_input = "password";
      fg = "0x01cd6400";
      full_color = true;
      hide_borders = false;
      hide_key_hints = false;
      hide_keyboard_locks = true;
      hide_version_string = false;
      input_len = 34;
      lang = "en";
      numlock = false;
      save = true;
      service_name = "ly";

      bigclock = "en";
      clock = "%H:%M";

      colormix_col1 = "0x08E85D04";
      colormix_col2 = "0x08FABD2F";
      colormix_col3 = "0x08FE8019";

      # Box appearance
      #border_fg = "0x00FFFFFF";
      blank_box = true;
      box_title = "tomasr@nixos";
      #margin_box_h = 2;
      #margin_box_v = 1;
      #text_in_center = false;

      # Animation: Conway’s Game of Life (optional, comment out for minimal setup)
      gameoflife_fg = "0x40FFFFFF";

      gameoflife_frame_delay = 3;
      gameoflife_entropy_interval = 10;
      gameoflife_initial_density = 0.666;

      # Optional commands (leave null or comment if unused)
      hibernate_cmd = null;
      inactivity_cmd = null;
      login_cmd = "start-hyprland";
      #logout_cmd = null;
      sleep_cmd = null;

      # System commands keys
      shutdown_cmd = "/sbin/shutdown $PLATFORM_SHUTDOWN_ARG now";
      shutdown_key = "F1";
      restart_key = "F2";
      sleep_key = "F3";
      hibernate_key = "F4";

      # top bar
      session_log = null;
      initial_info_text = null; #
      # Custom sessions
      #custom_sessions = "$CONFIG_DIRECTORY/ly/custom-sessions";
      #waylandsessions = "$PREFIX_DIRECTORY/share/wayland-sessions";
      #xsessions = "$PREFIX_DIRECTORY/share/xsessions";

      # Xorg settings (only needed if using X)
      #x_cmd = "$PREFIX_DIRECTORY/bin/X";
      #x_vt = null;
      #xauth_cmd = "$PREFIX_DIRECTORY/bin/xauth";
      #xinitrc = "~/.xinitrc";

      # Setup / startup scripts
      #setup_cmd = "$CONFIG_DIRECTORY/ly/setup.sh";
      #start_cmd = "$CONFIG_DIRECTORY/ly/startup.sh";
    };
  };
}
