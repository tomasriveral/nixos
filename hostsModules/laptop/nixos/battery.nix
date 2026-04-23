# https://discourse.nixos.org/t/what-is-the-best-option-for-power-management/63406/2
{...}:
# we just activate tlp unconditonally
#let
#  cfg = config.custom;
#hasBattery =
#    lib.any (x: lib.strings.hasPrefix "BAT" x)
#    (builtins.attrNames (builtins.readDir "/sys/class/power_supply"));
#in
{
  #  options.custom = {
  #     battery.enable = lib.mkOption {
  #     default = hasBattery;
  #     description = "Enable better battery support";
  #     type = lib.types.bool;
  #    };
  #  };

  #  config = lib.mkIf cfg.battery.enable {
  powerManagement.powertop.enable = true; # enable powertop auto tuning on startup.
  services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
  services.thermald.enable = true; # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)
  services.power-profiles-daemon.enable = false; # Disable GNOMEs power management
  services.tlp = {
    enable = true; # Enable TLP (better than gnomes internal power manager)
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 1;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 85;
    };
  };
  #  };
}
