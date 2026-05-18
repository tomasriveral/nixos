{pkgs, ...}: {
  # Ensure your script is available system-wide
  environment.systemPackages = [
    (pkgs.callPackage ../scripts/cleanNix.nix {})
  ];
  users.users.tomasr = {
    linger = true; # lingering is required
  };

  systemd.user.services.custom-cleanNix = {
    description = "NixOS configuration auto cleanup";

    serviceConfig = {
      Type = "oneshot";

      ExecStart = "/run/current-system/sw/bin/custom-cleanNix";

      # safety for long rebuilds
      TimeoutStartSec = "45min";
      TimeoutStopSec = "10min";

      # avoid overlap
      RemainAfterExit = true;

      # tweaks that should make the system run normally during the rebuilds
      Nice = 10;
      IOSchedulingClass = "best-effort";
      IOSchedulingPriority = 7;
    };
  };

  # Systemd USER timer
  systemd.user.timers.custom-cleanNix = {
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "Sat *-*-* 20:00:00"; # runs saturday night. If for whatever reason something breaks. I have whole sunday to fix it.

      Persistent = true; # if it happens during shutted down

      # avoids thundering herd on boot
      RandomizedDelaySec = "2h";
    };
  };
}
