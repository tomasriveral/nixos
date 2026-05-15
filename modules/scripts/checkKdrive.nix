{
  writeShellApplication,
  rclone,
  matrix-commander-rs,
  libnotify,
  ...
}:
writeShellApplication {
  name = "custom-checkKdrive";
  runtimeInputs = [
    rclone
    matrix-commander-rs
    libnotify
  ];
  text = ''
set +e

output=$(rclone lsd kdrive: 2>&1)
status=$?

set -e

if [ $status -eq 0 ]; then
  echo "kdrive OK"
else
  echo "kdrive rclone failed with error: $output"  
  notify-send "rclone kdrive failed" "$output"
  matrix-commander-rs --verbose -m "rclone kdrive failed.<br>Error: <pre>$output</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
  --html \
  -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
fi
  '';
}
