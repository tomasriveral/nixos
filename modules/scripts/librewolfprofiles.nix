{
  writeShellApplication,
  zsh,
  fzf,
  ...
}:
writeShellApplication {
  name = "custom-librewolfprofiles";
  runtimeInputs = [
    zsh
    fzf
  ];
  text = ''
    # List of profiles
    profiles=("work" "other")

    # Use fzf to select
    selected=$(printf "%s\n" "''${profiles[@]}" | fzf --height 6 --reverse --prompt="Select LibreWolf profile:")

    # If user cancels, exit
    [[ -z "$selected" ]] && exit 0

    # Launch LibreWolf detached, keeping environment
    setsid  librewolf -P "$selected" --no-remote >/dev/null 2>&1 &
        pkill -f "kitty.*Select LibreWolf profile"


    # Exit the kitty terminal after selection
    exit
  '';
}
