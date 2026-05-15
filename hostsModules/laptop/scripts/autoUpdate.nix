{
  pkgs,
  ...
}:
pkgs.writeShellApplication {
  name = "custom-autoupdate";

  runtimeInputs = with pkgs; [
    git
    nixos-rebuild
    matrix-commander-rs
    libnotify
  ];

  text = ''
    set -e

    FLAKE_DIR="/home/tomasr/nixos"
    FLAKE="$FLAKE_DIR#laptop"
    TIME=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

    ERROR_FILE=$(mktemp)

    # snapshot current state
    git -C "$FLAKE_DIR" add -A
    git -C "$FLAKE_DIR" commit --allow-empty -m "snapshot pre-autoupdate-$TIME"
    git -C "$FLAKE_DIR" tag "pre-autoupdate-$TIME" HEAD

    # update lock only
    nix flake update --flake "$FLAKE_DIR"

    if sudo nixos-rebuild switch --flake "$FLAKE" 2> "$ERROR_FILE"; then

      git -C "$FLAKE_DIR" add flake.lock
      git -C "$FLAKE_DIR" commit -m "flake.lock: autoupdate-$TIME"
      git -C "$FLAKE_DIR" push

      notify-send "Flake autoupdate" "Rebuild OK"

      matrix-commander-rs --verbose -m "Flake rebuild succesfull.<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
        --html \
        -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

    else
      ERROR_MSG=$(cat "$ERROR_FILE")

      notify-send -u critical "Flake autoupdate" "FAILED"

      matrix-commander-rs --verbose -m "Flake rebuild failed.<br>Error: <pre>$ERROR_MSG</pre><br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
        --html \
        -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"

      git -C "$FLAKE_DIR" reset --hard "pre-autoupdate-$TIME"
    fi
    
    git -C "$FLAKE_DIR" push
    rm -f "$ERROR_FILE"
  '';
}
