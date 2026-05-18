{
  writeShellApplication,
  fzf,
  pulseaudio,
  jq,
  ...
}:
writeShellApplication {
  name = "custom-changeAudioOutput";
  runtimeInputs = [
    fzf
    pulseaudio
    jq
  ];
  text = ''
    select=$(pactl -f json list sinks | jq -r '.[].name' | fzf)
    if [[ -n "$select" ]]; then
      pactl set-default-sink "$select"
    fi
    pkill -f "kitty.*Select audio output"
  '';
}
