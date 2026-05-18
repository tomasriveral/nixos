{pkgs}:
pkgs.writeShellApplication {
  name = "custom-checkMatrix";

  runtimeInputs = [
    pkgs.matrix-commander-rs
    pkgs.libnotify
  ];

  text = ''
    expected="@totorile1:unredacted.org"

    current="$(matrix-commander-rs --whoami | tr -d '\n')"

    if [ "$current" != "$expected" ]; then
      notify-send "matrix-commander-rs" \
        "You are not logged in as @totorile1:unredacted.org\nLog:\n$current"
    fi
  '';
}
