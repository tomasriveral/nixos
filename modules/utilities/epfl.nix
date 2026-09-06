_: {
  flake.nixosModules.epfl = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      openconnect
    ];
  };

  flake.nixosModules.cs-119l = {pkgs, ...}: 
  let
    user = "YOUR_USERNAME";
    home = "/home/${user}";
    src = "${home}/epfl/cs-119l-ICC/";
    dst = "${home}/kdrive/Travaille/2 - Bachelor/Information, calcul, communication CS-119l/";
  in
  {
    environment.systemPackages = with pkgs; [
      vscode-fhs
    ];
    systemd.services.sync-cs119l-to-kdrive = {
      description = "Sync CS-119l ICC to kDrive";
  
      serviceConfig = {
        Type = "oneshot";
        User = user;
  
        ExecStart =
          "${pkgs.rsync}/bin/rsync -a '${src}' '${dst}'";
      };
    };
  
    systemd.timers.sync-cs119l-to-kdrive = {
      description = "Sync CS-119l ICC to kDrive every Thursday and Friday evening";
  
      wantedBy = [ "timers.target" ];
  
      timerConfig = {
        OnCalendar = [
          "Thu *-*-* 20:00:00"
          "Fri *-*-* 20:00:00"
        ];
        Persistent = true;
      };
    };
  };
}
