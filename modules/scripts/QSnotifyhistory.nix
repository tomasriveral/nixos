{
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "QS-notifyhistory";
  runtimeInputs = [
  ];
  text = ''
    app="$1"
    title="$2"
    body="$3"
    date="$(date +%T)"
    urgency="$4"

    case "$urgency" in
      0) urgency_text="low";;
      1) urgency_text="normal";;
      2) urgency_text="critical";;
      *) urgency_text="unknown";;
    esac
    {
      echo "$app"
      echo "$title"
      echo "$body"
      echo "$date"
      echo "$urgency_text"

    } >> "$HOME/.cache/notify_history"
  '';
}
