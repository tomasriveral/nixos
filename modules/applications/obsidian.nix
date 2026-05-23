{ ... }: {
  # obsidian is unused -> see my project https://github.com/tomasriveral/NoteWrapper
  flake.homeModules.obsidian = { ... }: {
    programs.obsidian = {
      enable = true;

      vaults = {
        miscellanious = {
          enable = true;
          target = "/Documents/Notes/miscellanious";
        };
        work = {
          enable = true;
          target = "/Documents/Notes/work";
        };
      };

      defaultSettings = {
        appearance.theme = "gruvbox";

        extraFiles = {
          ".obsidian/themes/gruvbox/manifest.json" = ../../other/obsidian-theme/manifest.json;
          ".obsidian/themes/gruvbox/obsidian.css" = ../../other/obsidian-theme/obsidian.css;
          ".obsidian/themes/gruvbox/theme.css" = ../../other/obsidian-theme/theme.css;
        };
      };
    };
  };
  flake.packages.custom-obsidianbackup = {pkgs, ...}:
  pkgs.writeShellApplication {
    name = "custom-obsidianbackup";
    runtimeInputs = with pkgs; [
      rclone
      libnotify
      rsync
    ];
    text = ''
      #!/usr/bin/env bash
  
      SOURCE_DIR="$HOME/Documents/Notes"
      DEST_DIR="$HOME/kdrive/Notes"
      BACKUP_DIR="$HOME/.Notes.backup"
  
      mkdir -p "$DEST_DIR"
      mkdir -p "$BACKUP_DIR"
  
      while true; do
        # Timestamp for this run
        TIMESTAMP=$(date +%Y-%m-%d_%H-%M)
        TIMESTAMPED_BACKUP="$BACKUP_DIR/$TIMESTAMP"
        mkdir -p "$TIMESTAMPED_BACKUP"
  
        echo "[$(date)] Starting Obsidian backup..."
  
        # Check rclone mount
        status=$(rclone about kdrive: 2>&1 || true)
        if [[ "$status" =~ .*CRITICAL.* ]]; then
          echo "[$(date)] rclone failed:"
          echo "$status"
          notify-send -u critical "rclone failed" \
            "rclone might be broken or you need to deactivate this script in HomeManager."
        else
          # Run rsync with verbose debugging
          echo "[$(date)] Running rsync..."
          rsync -Lavh --progress --update --backup --backup-dir="$TIMESTAMPED_BACKUP" \
            --exclude='.obsidian/cache/**' \
            "$SOURCE_DIR/" "$DEST_DIR/"
  
          echo "[$(date)] Backup completed for this run."
        fi
  
        # Safely remove backups older than 30 days
        if [[ -d "$BACKUP_DIR" && "$BACKUP_DIR" == "$HOME/.Notes.backup" ]]; then
          echo "[$(date)] Cleaning old backups..."
          find "$BACKUP_DIR/" -mindepth 1 -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;
        else
          echo "[$(date)] Backup directory not safe. Skipping cleanup."
        fi
  
        # Wait 1 hour
        echo "[$(date)] Sleeping for 1 hour..."
        sleep 3600
      done
    '';
  };
  # this might be broken after dendritic nix. As it searched for the obsidian.nix to get list of vaults
  flake.packages.custom-obsidianvaults = {pkgs, ...}:
  pkgs.writeShellApplication {
    name = "custom-obsidianvaults";
    runtimeInputs = with pkgs; [
      zsh
      fzf
      ripgrep
    ];
    text = ''
      # Path to your obsidian.nix
      obsidian_nix="$HOME/nixos/modules/home-manager/obsidian.nix"
  
      # Extract vault names without line numbers and colors
      mapfile -t vaults < <(rg -N --color=never -Po 'vaults\.\K[[:alnum:]_]+' "$obsidian_nix")
  
      # Let user select a vault with fzf
      selected=$(printf "%s\n" "''${vaults[@]}" \
        | fzf --height 6 --reverse --prompt="Select Obsidian vault:")
  
      # Exit if user cancels
      [[ -z "$selected" ]] && exit 0
  
      # Remove any stray ANSI codes (optional)
      selected=$(echo "$selected" | sed -r 's/\x1B\[[0-9;]*[mK]//g')
  
      # Find the target path of the selected vault
      vault_path=$(rg -N --color=never -A2 "vaults.$selected" "$obsidian_nix" \
        | rg 'target =' | sed -E 's/.*"([^"]+)".*/\1/')
  
      # Expand ~ if present
      vault_path="''${vault_path/#\~/$HOME}"
  
      # Launch Obsidian with the selected vault using URI
      [[ -n "$vault_path" ]] && setsid xdg-open "obsidian://open?vault=$selected" >/dev/null 2>&1 &
      # Exit the kitty terminal after selection
      pkill -f "kitty.*Select Obsidian vault"
      exit
    '';
  };
}
