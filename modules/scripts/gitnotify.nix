{
  writeShellApplication,
  git,
  libnotify,
  ...
}:
writeShellApplication {
  name = "custom-gitnotify";
  runtimeInputs = [
    git
    libnotify
  ];
  text = ''
    # Check if git is installed
    if ! command -v git >/dev/null 2>&1; then
        exit 0
    fi

    NAME=$(git config --global user.name)
    EMAIL=$(git config --global user.email)

    if [[ -z "$NAME" || -z "$EMAIL" ]]; then
        notify-send \
            "Git not configured" \
            "Set your identity\n or remove this warning by removing the custom-gitnotify line in\n ~/nixos/modules/home-manager/hyprland.nix"
        matrix-commander-rs --verbose -m "Git not configured.<br>Set your identify or remove this warning by removing the custom-gitnotify in ~/nixos/modules/home-manager/hyprland.nix<br><a href=\"https://matrix.to/#/@notificationbot_0000:matrix.org\">@notificationbot_0000</a>" \
        --html \
        -r "\!7j-78_02dHROeLj4Ns8F12eo4IiZGv4zNsQ_1-WlyIU"
    fi
  '';
}
