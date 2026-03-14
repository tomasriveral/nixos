# creates and maintains cache file for the notification history
{
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "QS-notifycache";
  runtimeInputs = [
  ];
  text = ''
CACHE="$HOME/.cache/notify_history"
# Create or erase existing cache
mkdir -p "$(dirname "$CACHE")"
: > "$CACHE"  # truncate file
echo "Notification history initialized at $(date)" >> "$CACHE"
  '';
}
