{
  writeShellApplication,
  rclone,
  libnotify,
  rsync,
  ...
}:

writeShellApplication {
  name = "custom-obsidianbackup";
  runtimeInputs = [
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
}
