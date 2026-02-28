{ config, pkgs, ... }:


{
  programs.waybar = {
    enable = true;
    settings = [
    {
    	layer = "top";
	position = "left";
	margin = "5 2 5 0";
	reload_style_on_change = true;
	modules-left = [
		"hyprland/workspaces"
		"group/info"
	];
	
	
	modules-center = [
		"hyprland/window"
	];
	modules-right = [
		"group/brightness"
		"group/sound"
		"group/connection"
		"group/together"
		"tray"
		"group/power"
	];
	# groups settings are organized by alphabetical order	
	"group/audio" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = false;
		};
		modules = [
			"pulseaudio"
			"pulseaudio#mic"
			"pulseaudio/slider"
		];
	};
	"group/bluetooth" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = true;
		};
		modules = [
			"bluetooth"
			"bluetooth#status"
		];
	};
	"group/brightness" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = false;
		};
		modules = [
			"backlight"
			"backlight/slider"
		];
	};
	"group/connection" = {
		orientation = "inherit";
		modules = [ "group/network" ];
	};
	"group/gcpu" = {
		orientation = "inherit";
		modules = [
			"custom/cpu-icon"
			"temperature"
			"cpu"
		];
	};
	"group/info" = {
		orientation = "inherit";
		modules = [
			"group/gcpu"
			"memory"
			"disk"
		];
	};
	"group/network" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = true;
		};
		modules = [
			"network"
			"network#speed"
		];
	};
	"group/power" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = false;
		};
		modules = [
			"battery"
			"power-profiles-daemon"
		];
	};
	"group/sound" = {
		orientation = "inherit";
		modules = [
			"group/audio"
			"custom/notification"
		];
	};
	"group/together" = {
		orientation = "inherit";
		modules = [
			"group/utils"
			"clock"
		];
	};
	"group/utils" = {
		orientation = "inherit";
		drawer = {
			transition-duration = 500;
			transition-left-to-right = true;
		};
		modules = [
			"custom/weather"
			"custom/colorpicker"
		];
	};
	# modules settings are organized by alphabetical order
	backlight = {
		device = "intel_backlight"; # my laptop is amd and it works
		format = "{icon}";
		format-icons = [
			""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		        ""
		];
		on-scroll-down = "brightnessctl s 5%-";
		on-scroll-up = "brightness s +5%";
		tooltip = true;
		tooltip-format = "Brightness: {percent}%";
		smooth-scrolling-threshold = 1;
	};
	"backlight/slider" = {
		min = 5;
		max = 100;
		orientation = "vertical";
		device = "intel_backlight";
	};
	bluetooth = {
		format-on = "";
    		format-off = "󰂲";
    		format-disabled = "";
    		format-connected = "<b></b>";
    		tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
    		tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
    		tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    		tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
  	};
  	"bluetooth#status" = {
    		format-on = "";
    		format-off = "";
    		format-disabled = "";
    		format-connected = "<b>{num_connections}</b>";
    		format-connected-battery = "<small><b>{device_battery_percentage}%</b></small>";
    		tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
    		tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
    		tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    		tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
  	};
	clock = {
    		format = "{:%H\n%M}";
    		tooltip-format = "<tt><small>{calendar}</small></tt>";
    		calendar = {
      			mode = "month";
      			mode-mon-col = 3;
      			weeks-pos = "right";
      			on-scroll = 1;
      			on-click-right = "mode";
      			format = {
        			today = "<span color='#d65d0e'><b><u>{}</u></b></span>";
      			};
    		};
  	};
	cpu = {
		format = "<b>{usage}%</b>";
	};
	"custom/colorpicker" = {
    		format = "";
    		return-type = "json";
    		interval = "once";
    		exec = "custom-colorpicker -j";
    		on-click = "sleep 1 && ~/.config/waybar/scripts/colorpicker.sh";
    		signal = 1;
  	};
	"custom/cpu-icon" = {
		format = "󰻠";
		tooltip = false;
	};
	"custom/mark" = {
   		format = "";
    		tooltip = false;
  	};
	"custom/weather" = {
		format = "{}";
		interval = 3600;
		exec = "custom-weatherwaybar";
		return-type = "json";
	};
	disk = {
		interval = 600;
		format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
		path = "/"; #maybe we should subtract ~/kdrive if it is counted
	};
	"hyprland/window" = {
		format = "{class}";
		rotate = 90;
	};
	"hyprland/workspaces" = {
		format = "{icon}";
		format-icons = {
			"1" = "";
			"2" = "";
			"3" = "";
			"4" = "";
			"5" = "";
			"6" = "";
        		"7" = "";
        		"8" = "";
        		"9" = "";
        		"10" = "";
			"active" = "";
			"default" = ""; 
		};
		persistent-workspaces = {
			"*" = [ 1 2 3 4 5 6 7 8 9 10 ];
		};
	};
	idle_inhibitor = {
    		format = "{icon}";
    		tooltip-format-activated = "Idle Inhibitor is active";
    		tooltip-format-deactivated = "Idle Inhibitor is not active";
    		format-icons = {
      			activated = "󰔡";
      			deactivated = "󰔢";
    		};
  	};
	memory = {
		format = "<b>  \n{:2}󱉸</b>";
	};
	network = {
    		format = "{icon}";
    		format-icons = {
      			wifi = [ "󰤨" ];
      			ethernet = [ "󰈀" ];
      			disconnected = [ "󰖪" ];
    		};
		format-wifi = "󰤨";
		format-ethernet = "󰈀";
		format-disconnected = "󰖪";
		format-linked = "󰈁";
		tooltip = false;
	};
  	"network#speed" = {
    		format = " {bandwidthDownBits} ";
    		rotate = 90;
    		interval = 5;
    		tooltip-format = "{ipaddr}";
    		tooltip-format-wifi = "{essid} ({signalStrength}%)   \n{ipaddr} | {frequency} MHz{icon} ";
    		tooltip-format-ethernet = "{ifname} 󰈀 \n{ipaddr} | {frequency} MHz{icon} ";
    		tooltip-format-disconnected = "Not Connected to any type of Network";
    		tooltip = true;
  	};
	power-profiles-daemon = {
    		format = "{icon}";
    		tooltip-format = "Power profile: {profile}\nDriver: {driver}";
    		tooltip = true;
    		format-icons = {
      			default = "";
      			performance = "<span color='#B37F34'><small></small></span>";
      			balanced = "<span><small> </small></span>";
      			power-saver = "<span color='#a6e3a1'><small></small></span>";
    		};
  	};
	pulseaudio = {
		format = "{icon}";
		format-bluetooth = "{icon}";
		tooltip-format = "{volume}% {icon} | {desc}";
		format-muted = "󰖁";
    		format-icons = {
      			headphones = "󰋌";
     	 		handsfree = "󰋌";
      			headset = "󰋌";
      			phone = "";
      			portable = "";
      			car = " ";
      			default = [
        			"󰕿"
        			"󰖀"
        			"󰕾"
      			];
    		};
		on-click = "volume mute";
		on-click-middle = "pavucontrol";
		on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
		on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
		smooth-scrolling-threshold = 1;
  	};
  	"pulseaudio#mic" = {
    		format = "{format_source}";
    		format-source = "";
    		format-source-muted = "";
    		tooltip-format = "{volume}% {format_source}";
    		on-click = "pactl set-source-mute 0 toggle";
    		on-scroll-down = "pactl set-source-volume 0 -1%";
    		on-scroll-up = "pactl set-source-volume 0 +1%";
  	};
  	"pulseaudio/slider" = {
    		min = 0;
    		max = 140;
    		orientation = "vertical";
  	};
	temperature = {
		format = "{temperatureC}°C";
		format-critical = "{temperatureC}°C";
		interval = 10;
	};
	tray = {
		icon-size = 18;
		spacing = 10;
	};
    }
    ]; # home-manager wants the whole config as a list of bars
    style = ''
@define-color foreground #c5c5c5;
@define-color background #191919;
@define-color cursor #c5c5c5;

@define-color color0 #191919;
@define-color color1 #3a3632;
@define-color color2 #582c1e;
@define-color color3 #423f39;
@define-color color4 #50473c;
@define-color color5 #634723;
@define-color color6 #BAA470;
@define-color color7 #8c8c8c;
@define-color color8 #525252;
@define-color color9 #4e4843;
@define-color color10 #763b28;
@define-color color11 #59554c;
@define-color color12 #6b5f51;
@define-color color13 #855f2f;
@define-color color14 #796d62;
@define-color color15 #c5c5c5;

@define-color active @color6;

* {
  font-size: 16px;
  font-family: "0xProto Nerd Font";
  min-width: 8px;
  min-height: 0px;
  border: none;
  border-radius: 0;
  box-shadow: none;
  text-shadow: none;
  padding: 0px;

}

window#waybar {
  transition-property: background-color;
  transition-duration: 0.5s;
  border-radius: 8px;
  border: 2px solid @active;
  background: @background;
  background: alpha(@background, 0.7);
  color: lighter(@active);
}

menu,
tooltip {
  border-radius: 8px;
  padding: 2px;
  border: 1px solid lighter(@active);
  background: alpha(@background, 0.6);

  color: lighter(@active);
}

menu label,
tooltip label {
  font-size: 14px;
  color: lighter(@active);
}

#submap,
#tray>.needs-attention {
  animation-name: blink-active;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

.modules-right {
  margin: 0px 6px 6px 6px;
  border-radius: 4px;
  background: alpha(@background, 0.4);
  color: lighter(@active);
}

.modules-left {
  transition-property: background-color;
  transition-duration: 0.5s;
  margin: 6px 6px 6px 6px;
  border-radius: 4px;
  background: alpha(@background, 0.4);
  color: lighter(@active);
}

#gcpu,
#custom-github,
#memory,
#disk,
#together,
#submap,
#custom-weather
#custom-recorder,
#connection,
#cnoti,
#brightness,
#power,
#custom-updates,
#tray,
#audio,
#privacy,
#sound {
  border-radius: 4px;
  margin: 2px 2px 4px 2px;
  background: alpha(darker(@active), 0.3);
}

#custom-notifications {
  padding-left: 4px;
}

#custom-hotspot,
#custom-github,
#custom-notifications {
  font-size: 14px;
}

#custom-hotspot {
  padding-right: 2px;
}

#custom-vpn,
#custom-hotspot {
  background: alpha(darker(@active), 0.3);
}

#privacy-item {
  padding: 6px 0px 6px 6px;
}

#gcpu {
  padding: 8px 0px 8px 0px;
}

#custom-cpu-icon {
  font-size: 25px;
}

#custom-cputemp,
#disk,
#memory,
#cpu {
  font-size: 14px;
  font-weight: bold;
}

#custom-github {
  padding-top: 2px;
  padding-right: 4px;
}

#custom-dmark {
  color: alpha(@foreground, 0.3);
}

#submap {
  margin-bottom: 0px;
}

#workspaces {
  margin: 0px 2px;
  padding: 4px 0px 0px 0px;
  border-radius: 8px;
}

#workspaces button {
  transition-property: background-color;
  transition-duration: 0.5s;
  color: @foreground;
  background: transparent;
  border-radius: 4px;
  color: alpha(@foreground, 0.3);
}

#workspaces button.urgent {
  font-weight: bold;
  color: @foreground;
}

#workspaces button.active {
  padding: 4px 2px;
  background: alpha(@active, 0.4);
  color: lighter(@active);
  border-radius: 4px;
}

#network.wifi {
  padding-right: 4px;
}

#submap {
  min-width: 0px;
  margin: 4px 6px 4px 6px;
}

#tray {
  padding: 4px 0px 4px 0px;
}

#bluetooth {
  padding-top: 2px;
}

#window {
    border-radius: 8px;
    padding: 4px 14px;
    margin: 4px 2px 4px 2px;
}

#battery {
  border-radius: 8px;
  padding: 4px 0px;
  margin: 4px 2px 4px 2px;
}

#battery.discharging.warning {
  animation-name: blink-yellow;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#battery.discharging.critical {
  animation-name: blink-red;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#clock {
  font-weight: bold;
  padding: 4px 2px 2px 2px;
}

#pulseaudio.mic {
  border-radius: 4px;
  color: @background;
  background: alpha(darker(@foreground), 0.6);
  padding-left: 4px;
}

#backlight-slider slider,
#pulseaudio-slider slider {
  background-color: transparent;
  box-shadow: none;
}

#backlight-slider trough,
#pulseaudio-slider trough {
  margin-top: 4px;
  min-width: 6px;
  min-height: 60px;
  border-radius: 8px;
  background-color: alpha(@background, 0.6);
}

#backlight-slider highlight,
#pulseaudio-slider highlight {
  border-radius: 8px;
  background-color: lighter(@active);
}

#bluetooth.discoverable,
#bluetooth.discovering,
#bluetooth.pairable {
  border-radius: 8px;
  animation-name: blink-active;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink-active {
  to {
    background-color: @active;
    color: @foreground;
  }
}

@keyframes blink-red {
  to {
    background-color: #c64d4f;
    color: @foreground;
  }
}

@keyframes blink-yellow {
  to {
    background-color: #cf9022;
    color: @foreground;
  }
}
    '';
};
}
