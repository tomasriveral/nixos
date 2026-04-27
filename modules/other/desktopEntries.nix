{
  ...
}:
# see ../../docs/printing.md
{
  home.file.".local/share/applications/org.quickshell.desktop" = {
    enable = true;
    text = ''
      [Desktop Entry]
      Name=QuickShell
      Comment=QuickShell application
      Exec=quickshell
      Icon=utilities-terminal
      Type=Application
      Categories=Utility;
      StartupNotify=true
      X-DBUS-ServiceName=org.quickshell
    '';
  };
  home.file.".local/share/applications/org.kde.PrintQueue.desktop" = {
    enable = true;
    text = ''
      [Desktop Entry]
      Type=Application
      Name=Print Queue
      Exec=print-queue
      Icon=printer
      Categories=Utility;
      StartupNotify=true
      '';
  };
}
