{ ...}:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife"; # none or doom or matrix or gameoflife or a dur file
      animation_frame_delay = 5;
      animation_timeout_sec = 0;
      asterisk = "0x2022";
      auth_fails = 2; # numbers of failed authentification before special animation
      battery_id = "BAT1";
      bigclock = "en";
      bigclock_12hr = false;
      bigclock_seconds = false;
      # Blank main box background
      # Setting to false will make it transparent
      blank_box = false;
      
      # Border foreground color id
      border_fg = "0x00FFFFFF";
      
      # Title to show at the top of the main box
      # If set to null, none will be shown
      box_title = null;
      
      # Brightness decrease command
      brightness_down_cmd = "$PREFIX_DIRECTORY/bin/brightnessctl -q -n s 10%-";
      
      # Brightness decrease key combination, or null to disable
      brightness_down_key = "F5";
      
      # Brightness increase command
      brightness_up_cmd = "$PREFIX_DIRECTORY/bin/brightnessctl -q -n s +10%";
      
      # Brightness increase key combination, or null to disable
      brightness_up_key = "F6";
      
      # Erase password input on failure
      clear_password = true;
      
      # Format string for clock in top right corner (see strftime specification). Example: %c
      # If null, the clock won't be shown
      clock = true;
      
      # CMatrix animation foreground color id
      cmatrix_fg = "0x0000FF00";
      
      # CMatrix animation character string head color id
      cmatrix_head_col = "0x01FFFFFF";
      
      # CMatrix animation minimum codepoint. It uses a 16-bit integer
      # For Japanese characters for example, you can use 0x3000 here
      cmatrix_min_codepoint = "0x21";
      
      # CMatrix animation maximum codepoint. It uses a 16-bit integer
      # For Japanese characters for example, you can use 0x30FF here
      cmatrix_max_codepoint = "0x7B";
      
      # Color mixing animation first color id
      colormix_col1 = "0x00FF0000";
      
      # Color mixing animation second color id
      colormix_col2 = "0x000000FF";
      
      # Color mixing animation third color id
      colormix_col3 = "0x20000000";
      
      # Custom sessions directory
      # You can specify multiple directories,
      # e.g. $CONFIG_DIRECTORY/ly/custom-sessions:$PREFIX_DIRECTORY/share/custom-sessions
      custom_sessions = "$CONFIG_DIRECTORY/ly/custom-sessions";
      
      # Input box active by default on startup
      # Available inputs: info_line, session, login, password
      default_input = "password";
      
      # DOOM animation fire height (1 thru 9)
      doom_fire_height = 6;
      
      # DOOM animation fire spread (0 thru 4)
      doom_fire_spread = 2;
      
      # DOOM animation custom top color (low intensity flames)
      doom_top_color = "0x009F2707";
      
      # DOOM animation custom middle color (medium intensity flames)
      doom_middle_color = "0x00C78F17";
      
      # DOOM animation custom bottom color (high intensity flames)
      doom_bottom_color = "0x00FFFFFF";
      
      # Dur file path
      dur_file_path = "$CONFIG_DIRECTORY/ly/example.dur";
      
      # Dur file alignment
      # The dur file can be aligned with a direction and centered easily with the flags below
      # Available inputs: topleft, topcenter, topright, centerleft, center, centerright, bottomleft, bottomcenter, bottomright
      dur_offset_alignment = "center";
      
      # Dur offset x direction (value is added to the current position determined by alignment, negatives are supported)
      dur_x_offset = 0;
      
      # Dur offset y direction (value is added to the current position determined by alignment, negatives are supported)
      dur_y_offset = 0;
      
      # Set margin to the edges of the DM (useful for curved monitors)
      edge_margin = 0;
      
      # Error background color id
      error_bg = "0x00000000";
      
      # Error foreground color id
      # Default is red and bold
      error_fg = "0x01FF0000";
      
      # Foreground color id
      fg = "0x00FFFFFF";
      
      # Render true colors (if supported)
      # If false, output will be in eight-color mode
      # All eight-color mode color codes:
      # TB_DEFAULT              0x0000
      # TB_BLACK                0x0001
      # TB_RED                  0x0002
      # TB_GREEN                0x0003
      # TB_YELLOW               0x0004
      # TB_BLUE                 0x0005
      # TB_MAGENTA              0x0006
      # TB_CYAN                 0x0007
      # TB_WHITE                0x0008
      # If full color is off, the styling options still work. The colors are
      # always 32-bit values with the styling in the most significant byte.
      # Note: If using the dur_file animation option and the dur file's color range
      # is saved as 256 with this option disabled, the file will not be drawn.
      full_color = true;
      
      # Game of Life entropy interval (0 = disabled, >0 = add entropy every N generations)
      # 0 -> Pure Conway's Game of Life (will eventually stabilize)
      # 10 -> Add entropy every 10 generations (recommended for continuous activity)
      # 50+ -> Less frequent entropy for more natural evolution
      gameoflife_entropy_interval = 10;
      
      # Game of Life animation foreground color id
      gameoflife_fg = "0x0000FF00";
      
      # Game of Life frame delay (lower = faster animation, higher = slower)
      # 1-3 -> Very fast animation
      # 6 -> Default smooth animation speed
      # 10+ -> Slower, more contemplative speed
      gameoflife_frame_delay = 3;
      
      # Game of Life initial cell density (0.0 to 1.0)
      # 0.1 -> Sparse, minimal activity
      # 0.4 -> Balanced activity (recommended)
      # 0.7+ -> Dense, chaotic patterns
      gameoflife_initial_density = 0.666;
      
      # Command executed when pressing hibernate key (can be null)
      hibernate_cmd = null;
      
      # Specifies the key combination used for hibernate
      hibernate_key = "F4";
      
      # Remove main box borders
      hide_borders = false;
      
      # Remove power management command hints
      hide_key_hints = false;
      
      # Remove keyboard lock states from the top right corner
      hide_keyboard_locks = false;
      
      # Remove version number from the top left corner
      hide_version_string = false;
      
      # Command executed when no input is detected for a certain time
      # If null, no command will be executed
      inactivity_cmd = null;
      
      # Executes a command after a certain amount of seconds
      inactivity_delay = 0;
      
      # Initial text to show on the info line
      # If set to null, the info line defaults to the hostname
      initial_info_text = null;
      
      # Input boxes length
      input_len = 34;
      
      # Active language
      # Available languages are found in $CONFIG_DIRECTORY/ly/lang/
      lang = "en";
      
      # Command executed when logging in
      # If null, no command will be executed
      # Important: the code itself must end with `exec "$@"` in order to launch the session!
      # You can also set environment variables in there, they'll persist until logout
      login_cmd = null;
      
      # Path for login.defs file (used for listing all local users on the system on
      # Linux)
      #login_defs_path = /etc/login.defs
      
      # Command executed when logging out
      # If null, no command will be executed
      # Important: the session will already be terminated when this command is executed, so
      # no need to add `exec "$@"` at the end
      logout_cmd = null;
      
      # General log file path
      #ly_log = /var/log/ly.log
      
      # Main box horizontal margin
      margin_box_h = 2;
      
      # Main box vertical margin
      margin_box_v = 1;
      
      # Set numlock on/off at startup
      numlock = false;
      
      # Default path
      # If null, ly doesn't set a path
      #path = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
      
      # Command executed when pressing restart_key
      #restart_cmd = "/sbin/shutdown -r now"
      
      # Specifies the key combination used for restart
      restart_key = "F2";
      
      # Save the current desktop and login as defaults, and load them on startup
      save = true;
      
      # Service name (set to ly to use the provided pam config file)
      service_name = "ly";
      
      # Session log file path
      # This will contain stdout and stderr of Wayland sessions
      # By default it's saved in the user's home directory
      # Important: due to technical limitations, X11, shell sessions as well as
      # launching session via KMSCON aren't supported, which means you won't get any
      # logs from those sessions.
      # If null, no session log will be created
      session_log = null;
      
      # Setup command
      setup_cmd = "$CONFIG_DIRECTORY/ly/setup.sh";
      
      # Command executed when pressing shutdown_key
      shutdown_cmd = "/sbin/shutdown $PLATFORM_SHUTDOWN_ARG now";
      
      # Specifies the key combination used for shutdown
      shutdown_key = "F1";
      
      # Command executed when pressing sleep key (can be null)
      sleep_cmd = null;
      
      # Specifies the key combination used for sleep
      sleep_key = "F3";
      
      # Command executed when starting Ly (before the TTY is taken control of)
      # See file at path below for an example of changing the default TTY colors
      start_cmd = "$CONFIG_DIRECTORY/ly/startup.sh";
      
      # Center the session name.
      text_in_center = false;
      
      # Default vi mode
      # normal   -> normal mode
      # insert   -> insert mode
      vi_default_mode = "normal";
      
      # Enable vi keybindings
      vi_mode = false;
      
      # Wayland desktop environments
      # You can specify multiple directories,
      # e.g. $PREFIX_DIRECTORY/share/wayland-sessions:$PREFIX_DIRECTORY/local/share/wayland-sessions
      waylandsessions = "$PREFIX_DIRECTORY/share/wayland-sessions";
      
      # Xorg server command
      x_cmd = "$PREFIX_DIRECTORY/bin/X";
      
      # Xorg virtual terminal number
      # Mostly useful for FreeBSD where choosing the current TTY causes issues
      # If null, the current TTY will be chosen
      x_vt = null;
      
      # Xorg xauthority edition tool
      xauth_cmd = "$PREFIX_DIRECTORY/bin/xauth";
      
      # xinitrc
      # If null, the xinitrc session will be hidden
      xinitrc = "~/.xinitrc";
      
      # Xorg desktop environments
      # You can specify multiple directories,
      # e.g. $PREFIX_DIRECTORY/share/xsessions:$PREFIX_DIRECTORY/local/share/xsessions
      xsessions = "$PREFIX_DIRECTORY/share/xsessions";
        };
      };
}
