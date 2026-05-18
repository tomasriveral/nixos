# don't works. some GTK error. I let it here if someday, someone is interest in this shit.
# ChatGPT half baked a replacement that works on my system.
# see ../qt/qtbatticon
_: {
  services.cbatticon = {
    enable = true;
    lowLevelPercent = 20;
    criticalLevelPercent = 5;
    batteryId = "BAT1";
    hideNotification = true; # we use another script for battery notifications
    updateIntervalSeconds = 10;
  };
}
