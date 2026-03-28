{
  writeShellApplication,
  rclone,
  libnotify,
  ...
}:
writeShellApplication {
  name = "custom-mountkdrive";
  runtimeInputs = [
    rclone
    libnotify
  ];
  text = ''
    REMOTE_NAME="kdrive"
    MOUNT_POINT="$HOME/kdrive"

    if rclone listremotes | rg "^''${REMOTE_NAME}:"; then
        echo "Mounting ''${REMOTE_NAME}..."
        rclone mount "''${REMOTE_NAME}:" "$MOUNT_POINT" --vfs-cache-mode writes --allow-non-empty &
    else
        notify-send "rclone mount failed" \
            "Remote ''${REMOTE_NAME} not found.\nConfigure rclone and create the dir ~/kdrive/ or comment out the exec line in hyprland.nix."
    echo        "Remote ''${REMOTE_NAME} not found. Configure rclone or comment out the exec line in hyprland.nix."
    fi
  '';
}
