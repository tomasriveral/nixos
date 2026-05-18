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

    # waits for an internet connection. It pings both Google DNS  and Cloudfare dns in case one of them is down
    until ping -c1 -W1 1.1.1.1 >/dev/null 2>&1 || \
      ping -c1 -W1 8.8.8.8 >/dev/null 2>&1
    do
      sleep 1
    done

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
