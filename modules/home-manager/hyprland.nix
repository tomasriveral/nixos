{ config, pkgs, ... }:

let 
	wallpaper = ../../assets/wallpaper1.jpg;
in
{


	#refer to https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
	wayland.windowManager.hyprland.enable = true;

	#hint Electron apps to use on wayland;
	home.sessionVariables.NIXOS_OZONE_WL="1";

	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER";
		"$term" = "kitty";
		"$editor" = "nvim";
		"$file" = "nautilus";
		"$browser" = "firefox"; # change to librewolf later
# ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
# █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

# █▀▀ █▄░█ █░█
# ██▄ █░▀█ ▀▄▀

	# See https://wiki.hyprland.org/Configuring/Environment-variables/
		env = [
			"PATH, $PATH:$scrPath"
			"XDG_CURRENT_DESKTOP,Hyprland"
			"XDG_SESSION_TYPE,wayland"
			"XDG_SESSION_DESKTOP,Hyprland"
			"QT_QPA_PLATFORM,wayland;xcb"
			"QT_QPAPLATFORMTHEME,qt6ct"
			"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
			"MOZ_ENABLE_WAYLAND,1"
			"GDK_SCALE,1"
		];

# █ █▄░█ █▀█ █░█ ▀█▀
# █ █░▀█ █▀▀ █▄█ ░█░

		input = {
			kb_layout = [ "ch" ];
			follow_mouse = 1;
			sensitivity = 0;
			force_no_accel = 1;
			};

# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█
		#not all binds now. Do it later when all scripts and etc. are moved
		bind = [
			#hyprland/utility keybindings
			"$mod, W, togglefloating"
			"$mod, G, togglegroup"
			"Alt, Return, fullscreen"
			"$mod, Left, movefocus, l"
			"$mod, Right, movefocus, r"
			"$mod, Up, movefocus, u"
			"$mod, Down, movefocus, d"
			"Alt, Tab, movefocus, d"
			"$mod, 1, workspace, 1"
			"$mod, 2, workspace, 2"
			"$mod, 3, workspace, 3"
			"$mod, 4, workspace, 4"
			"$mod, 5, workspace, 5"
			"$mod, 6, workspace, 6"
			"$mod, 7, workspace, 7"
			"$mod, 8, workspace, 8"
			"$mod, 9, workspace, 9"
			"$mod, 0, workspace, 10"
			"$mod+Ctrl, Right, workspace, r+1"
			"$mod+Ctrl, Left, workspace, r-1"
			"$mod+Ctrl, Doown, workspace, empty"
			"$mod+Shift, 1, movetoworkspace, 1"
			"$mod+Shift, 2, movetoworkspace, 2"
			"$mod+Shift, 3, movetoworkspace, 3"
			"$mod+Shift, 4, movetoworkspace, 4"
			"$mod+Shift, 5, movetoworkspace, 5"
			"$mod+Shift, 6, movetoworkspace, 6"
			"$mod+Shift, 7, movetoworkspace, 7"
			"$mod+Shift, 8, movetoworkspace, 8"
			"$mod+Shift, 9, movetoworkspace, 9"
			"$mod+Shift, 0, movetoworkspace, 10"
			"$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
			"$mod+Ctrl+Alt, Left, movetoworkspace, r-1"
			"$mod, Backspace, exec, wlogout -b 5 -T 600 -B 600"
			"$mod+Shift+Ctrl, Left, movewindow, l"
			"$mod+Shift+Ctrl, Right, movewindow, r"
			"$mod+Shift+Ctrl, Up, movewindow, u"
			"$mod+Shift+Ctrl, Down, movewindow, d"
			"$mod, mouse_down, workspace, e+1"
			"$mod, mouse_up, workspace, e-1"
			"$mod, V, exec, cliphist list | rofi -dmenu| cliphist decode | wl-copy" # copy paste
			"$mod, B, exec, hyprkeys -bkr | rofi -dmenu"
			#apps keybindings
			"$mod, T, exec, $term"
			"$mod, E, exec, $file"
			"$mod, F, exec, $browser"
			"$mod+Shift, A, exec, rofi -show drun"
			"$mod, Q, exec, custom-dontkillsteam"	
			#plugins keybindings

		];
		binde = [
			"$mod+Shift, Right, resizeactive, 30 0"
			"$mod+Shift, Left, resizeactive, -30, 0"
			"$mod+Shift, Up, resizeactive, 0 -30"
			"$mod+Shift, Down, resizeactive,m 0 30"
		];
		bindl = [
			", F1, exec, pactl set-sink-mute @DEFAULT_SINK@ togge" #toggle audio mute
			", F5, exec, playerctl play-pause" # media F4-F6
			", F4, exec, playerctl previous"
			", F6, exec, playerctl next"
		];
		bindel = [
			", F2, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%" # decrease volume
			", F3, exec, pactl set-sinl-volume @DEFAULT_SINK@ +10%" # increase volume
			", F7, exec, brightnessctl s 10%-" # decrease brightness
			", F8, exec, brightnessctl s +10%" # increase brightness
		];
		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
			"$mod, Z, movewindow"
			"$mod, X, resizewindow"
		];
# █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
# █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
		exec-once = [
			"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
			"dbus-update-activation-environment --systemd --all" # for XDPH
			"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
			"systemctl --user start xdg-desktop-portal-wlr.service"
			"blueman-applet" # systray app for Bluetooth
			"udiskie --no-automount --smart-tray" # front-end that allows to manage removable media	
			"nm-applet --indicator" # systray app for Network/wifi
			"wl-paste --type text --watch cliphist store" # clipboard store text data
			"wl-paste --type image --watch cliphist store" # clipboard store image data
			"custom-batterynotify"
			#wallpapers
			"swww img ${wallpaper}"
			"swww-daemon"
			"sleep 1 && custom-wallpaper"
			"custom-mountkdrive"
		];
# █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
# █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

# █▀▄▀█ █ █▀ █▀▀
# █░▀░█ █ ▄█ █▄▄

		misc = {
			vrr = 0;
			force_default_wallpaper = 0;
		};
		xwayland = {
			force_zero_scaling = true;
		};

# █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
# █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
		monitor = [
			",preferred, auto, auto"
		];
	};
}
