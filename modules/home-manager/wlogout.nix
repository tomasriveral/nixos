{ config, pkgs, ... }:
let
  wallpaper = ../../assets/wallpaper1.jpg;
  lock = ../../assets/lock.png;
  lock-hover = ../../assets/lock-hover.png;
  shutdown = ../../assets/power.png;
  shutdown-hover = ../../assets/power-hover.png;
  logout = ../../assets/logout.png;
  logout-hover = ../../assets/logout-hover.png;
  reboot = ../../assets/restart.png;
  reboot-hover = ../../assets/restart-hover.png;
in  
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "swaylock -eFLfk -i ${wallpaper}";
        text = "  Lock (L)  ";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = " Reboot (R) ";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown (S)";
        keybind = "s";
      }
      {
        label = "logout";
        action = "loginctl terminate-session $(loginctl show-session $(loginctl | grep $USER | awk '{print $1}') -p Id --value)";
        text = " Logout (E) ";
        keybind = "e";
      }
    ];
    style = ''
window {
  font-family: OxProto Nerd Font;
  font-size: 14pt;
      color: #000000; /* text */
  background-color: rgba(40, 40, 40, 0.76);
}

button {
  background-repeat: no-repeat;
  background-position: center;
  background-size: 50%;
  border-style: solid;
  border-radius: 4px;
  border-width: 2px;
  border-color: #ebdbb2;
  background-color: rgba(40, 40, 40, 0.76);
  margin: 10px;
  transition:
    box-shadow 0.3s ease-in-out,
    background-color 0.3s ease-in-out;
}

button:hover {
  background-color: rgba(250, 137, 26, 0.3);
  color: #282828;
}

button:focus {
  background-color: #ebdbb2;
  color: #282828;
}

#lock {
  background-image: image(url("${lock}"));
}
#lock:focus {
  background-image: image(url("${lock-hover}"));
}
#lock:hover {
  background-image: image(url("${lock-hover}"));
}

#logout {
  background-image: image(url("${logout}"));
}
#logout:focus {
  background-image: image(url("${logout-hover}"));
}
#logout:hover {
  background-image: image(url("${logout-hover}"));
}


#shutdown {
  background-image: image(url("${shutdown}"));
}
#shutdown:focus {
  background-image: image(url("${shutdown-hover}"));
}
#shutdown:hover {
  background-image: image(url("${shutdown-hover}"));
}

#reboot {
  background-image: image(url("${reboot}"));
}
#reboot:focus {
  background-image: image(url("${reboot-hover}"));
}
#reboot:hover {
  background-image: image(url("${reboot-hover}"));
}
'';
};
}
