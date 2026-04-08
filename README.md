# NixOS Configuration
![NixOS configuration](/assets/example.png)

## Installation Guide

⚠️ **Important Notes**  
Before applying this configuration on another system, make sure to:
- Update the `hostName`.
- If your computer **is not a laptop**, set `isLaptop = false` in `~/nixos/other/quickshell/bar/Power.qml`.  
  *(This is hardcoded because `UPowerDevice.isLaptopBattery` didn’t work.)*

Requirements: `git` installed. Then run:

```bash
cd
git clone https://github.com/Totorile1/nixos.git
cd nixos
sudo cp /etc/nixos/hardware-configuration.nix ./hosts/laptop/hardware-configuration
sudo nixos-rebuild switch --flake ~/nixos/#laptop
```

### Things That Don't Work Reliably and need manual setup

- Librewolf's extension settings
- Librewolf's bookmarks
- Thunderbird's email servers

---

## Configuration Structure

```text
nixos/
├── assets/                # Images, icons, wallpapers, sounds
├── hosts/laptop/          # Host-specific NixOS config
├── modules/
│   ├── home-manager/      # User-level configurations (apps, shell, WM, plugins)
│   ├── nixos/             # System-level modules (daemons, services, udev, ly)
│   └── scripts/           # Custom scripts called from keybinds or tools
├── other/
│   ├── kblayouts/         # Framework 16 RGB macropad layout
│   └── quickshell/        # QML configuration for topbar, notifications, screenshot, etc.
├── flake.nix
├── flake.lock
└── README.md
```

> The `quickshell` configuration is written in **QML** (`other/quickshell`) and is automatically copied to `~/.config/quickshell` on deployment.  

---

## Applications & Tools

### Shell & Terminal
- [`zsh`](https://www.zsh.org/) with [`oh-my-zsh`](https://ohmyz.sh/) for shell customization  
- [`kitty`](https://sw.kovidgoyal.net/kitty/) terminal  

### Window Management
- [`hyprland`](https://github.com/hyprwm/Hyprland) (tiling window manager)  
- [`ly`](https://github.com/fairyglade/ly) login manager  
- [`swaylock`](https://github.com/swaywm/swaylock) screen locking  
- [`hypridle`](https://github.com/hyprwm/Hyprland/wiki/HyprIdle) for idle mode  

### Browsing & Productivity
- [`librewolf`](https://librewolf-community.gitlab.io/) browser  
  - Extensions: [AdNauseam](https://github.com/dhowe/AdNauseam), [Enhancer for YouTube](https://github.com/ParticleCore/yt-enhancer), [TrackMeNot](https://www.tornhq.com/tmn/), [SponsorBlock](https://sponsor.ajay.app/)  
  - Privacy options mostly enabled; some disabled to avoid conflicts with AdNauseam  
- [`thunderbird`](https://www.thunderbird.net/) email client  
- [`obsidian`](https://obsidian.md/) notes and knowledge management  
- [`libreoffice`](https://www.libreoffice.org/) full-featured office suite  

### Utilities
- [`cliphist`](https://github.com/skywind3000/cliphist) clipboard manager  
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) faster directory navigation  
- [`fastfetch`](https://github.com/LinusDierheimer/fastfetch) system info  
- [`gnome-calculator`](https://wiki.gnome.org/Apps/Calculator)  
- [`gnome-characters`](https://wiki.gnome.org/Apps/Characters)  
- [`gnome-disk-utility`](https://wiki.gnome.org/Apps/Disks)  
- [`gnome-font-viewer`](https://wiki.gnome.org/Apps/FontViewer)  
- [`nautilus`](https://wiki.gnome.org/Apps/Nautilus) file manager  
- [`okular`](https://okular.kde.org/) document & image viewer  
- [`vlc`](https://www.videolan.org/vlc/) media player  
- [`krita`](https://krita.org/) image editing  
- [`anki`](https://apps.ankiweb.net/) flashcards for learning  
- [`texlive`](https://www.tug.org/texlive/) LaTeX distribution  
- [`biber`](https://ctan.org/pkg/biber) bibliography for LaTeX  

### System & Hardware
- [`bottom`](https://github.com/ClementTsang/bottom) system monitor  
- [`tomato-c`](https://github.com/erikras/tomato-c) Pomodoro timer  
- [`framework-tool-tui`](https://github.com/romanl/fx16-tui) Framework 16 laptop settings  

**Daemons:** `upower`, `pipewire`, `pulseaudio`, `brightnessctl`, `playerctl`, `blueman`, `udiskie`, `networkmanager-applet`, `swww` wallpaper daemon  

### Screenshots & Notifications
- [`grim`](https://github.com/emersion/grim) (with `quickshell`) screenshots  
- [`quickshell`](https://github.com/Totorile1/quickshell) notifications, top bar, and widgets  
- [`wlogout`](https://github.com/ArtsyMacaw/wlogout) logout/shutdown widget  

---

## Keybindings

### Window Management
| Key | Action |
|-----|--------|
| `$mod + W` | Toggle floating |
| `$mod + G` | Toggle group |
| `Alt + Return` | Fullscreen |
| `$mod + Arrow keys` / `Alt + Tab` | Move focus |
| `$mod + Shift + Ctrl + Arrow keys` | Move window |
| `$mod + Shift + Arrow keys` | Resize window |

### Workspaces
| Key | Action |
|-----|--------|
| `$mod + 1..0` | Switch workspace |
| `$mod + Shift + 1..0` | Move window to workspace |
| `$mod + Ctrl + Arrow keys` | Cycle workspaces |
| `$mod + Mouse wheel` | Scroll workspace |
| `$mod + S` / `Alt + $mod + S` | Special workspace |

### Layout
| Key | Action |
|-----|--------|
| `$mod + A` | Scroll layout column left |
| `$mod + D` | Scroll layout column right |

### Applications
| Key | Action |
|-----|--------|
| `$mod + T` | Terminal |
| `$mod + E` | File manager |
| `$mod + F` | Browser |
| `$mod + N` | Notes |
| `$mod + Shift + A` | App launcher |
| `$mod + Alt + A` | Toggle sidebar | 
| `$mod + Q` | Kill apps (Steam/Pomodoro to special workspace) |
| `$mod + L` | Lock screen |
| `$mod + Shift + S` | Screenshot a window|
| `F11` | Screenshot the whole screen|

### Multimedia & System
| Key | Action |
|-----|--------|
| F1 | Mute audio |
| F2 / F3 | Volume down / up |
| F4 / F5 / F6 | Media prev / play / next |
| F7 / F8 | Brightness down / up |
| `$mod + mouse` | Move / resize window |

---

### Framework 16 RGB Macropad

The **Framework 16 RGB macropad** is a 4×6 programmable key grid. Each key triggers one of the keybindings above via a macro.  

If you **don’t have the physical macropad**, the table below shows which keybinding each macro triggers so you can run it from the keyboard instead:

| Macropad Key | Linked Action (Hyprland keybinding)          |
| ------------ | -------------------------------------------- |
| Row 1, Col 1 | Kill all apps except focused (`Ctrl+$mod+6`) |
| Row 2, Col 1 | Performance mode (`Ctrl+Alt+7`)              |
| Row 3, Col 2 | Special characters (`Ctrl+$mod+3`)           |
| Row 3, Col 3 | Color picker (`Ctrl+Alt+8`)                  |
| Row 4, Col 1 | Notification center toggle (`Ctrl+Alt+1`)    |
| Row 4, Col 2 | System monitor (`Ctrl+Alt+2`)                |
| Row 4, Col 3 | Pomodoro timer (`Ctrl+Alt+0`)                |
| Row 4, Col 6 | Launch Anki (`Ctrl+Alt+9`)                   |

> Positions are labeled as `[row, column]` starting from top-left `[1,1]`.  
> Each macro calls a script or application from this configuration.

---

## Aliases

| Alias  | Command                                                           |
| ------ | ----------------------------------------------------------------- |
| `snrt` | `git add -A && sudo nixos-rebuild test --flake ~/nixos/#laptop`   |
| `snrs` | `git add -A && sudo nixos-rebuild switch --flake ~/nixos/#laptop` |

---

## Useful Information

- `man` and `manix` use `fzf` for fuzzy search of pages.  
- `pkgs-unstable` can be used for unstable nixpkgs packages.  
- Nix garbage collection runs weekly, deleting generations older than 7 days.  
- Non-free packages (e.g., Obsidian) are allowed.  
- `neovim` plugins configured in `./modules/home-manager/neovim.nix`  
- `oh-my-zsh` plugins configured in `./modules/home-manager/oh-my-zsh.nix`  
- `ripgrep` default flags: `-S -. -p -n`  
- Wallpapers change per workspace (5 paintings from Thomas Cole’s *The Course of Empire*).  
- LibreWolf search engines: `@q` (Quant), `@hm` (Home-manager), `@np` (nixpkgs), `@nw` (Nixwiki), `@map` (OpenStreetMap).  
- `ccat` colors `cat` output when not redirected; disables coloring if output is redirected (e.g., `>>`) to avoid breaking pipelines.  
- Anki addons: `./modules/nixos/anki.nix`  
- TLP config: `./modules/nixos/battery.nix`  
- Framework 16 RGB macropad layout: `./other/kblayouts/framework_laptop_16_rgb_macropad.layout.json`  
