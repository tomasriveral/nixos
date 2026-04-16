{
  ...
}:
# add a desktop entry here if you have an error like
# Failed to register with host portal QDBusError("org.freedesktop.portal.Error.Failed", "Could not register app ID: App info not found for 'org.quickshell'")

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
}
