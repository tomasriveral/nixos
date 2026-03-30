# used for the terminal autostart. Needs to get cleared and recall fastfetch so that the bar from oh-my-zsh get resized
{
  writeShellApplication,
  zsh,
  ...
}:
writeShellApplication {
  name = "custom-launch";
  runtimeInputs = [
    zsh
  ];
  text = ''
    sleep 2
    clear
    zsh
  '';
}
