{... }:
{
  # a minimal ly config as the big config (ly.nix) didnt worked
  services.displayManager.ly = {
    enable = true;
    settings = {
      # Core animation
      animation = "gameoflife"; # none or doom or matrix or gameoflife or a dur file

      # Basic TUI settings
      clear_password = true;
      default_input = "password";
      fg = "0x00FFFFFF";
      full_color = true;
      hide_borders = false;
      hide_key_hints = true;
      hide_keyboard_locks = true;
      hide_version_string = true;
      input_len = 34;
      lang = "en";
      numlock = false;
      save = true;
      service_name = "ly";

      # Box appearance
      #border_fg = "0x00FFFFFF";
      blank_box = true;
      box_title = "tomasr@nixos";
      #margin_box_h = 2;
      #margin_box_v = 1;
      #text_in_center = false;

      # Animation: Conway’s Game of Life (optional, comment out for minimal setup)
      gameoflife_fg = "0xdecda600";

      gameoflife_frame_delay = 3;
      gameoflife_entropy_interval = 10;
      gameoflife_initial_density = 0.666;

      # Optional commands (leave null or comment if unused)
      hibernate_cmd = null;
      inactivity_cmd = null;
      #login_cmd = "exec hyprland";
      logout_cmd = null;
      sleep_cmd = null;

      # System commands keys
      shutdown_cmd = "/sbin/shutdown $PLATFORM_SHUTDOWN_ARG now";
      shutdown_key = "F1";
      restart_key = "F2";
      sleep_key = "F3";
      hibernate_key = "F4";
      
      # top bar
      session_log = null;
      initial_info_text = null;  #
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
