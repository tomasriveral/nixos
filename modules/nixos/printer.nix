{
  config,
  pkgs,
  ...
}: {
  #https://wiki.nixos.org/wiki/Printing
    services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      #cups-browsed
      #gutenprint
      #gutenprintBin
      hplipWithPlugin
      hplip
    ];
  };
  services.ipp-usb.enable = true;
  environment.systemPackages = with pkgs; [ 
    kdePackages.print-manager
    ghostscript
    hplipWithPlugin
  ];
hardware.printers = {
  ensurePrinters = [
    {
      name = "HP_OfficeJet_Pro_7740";
      location = "Home";
      deviceUri = "hp:/usb/OfficeJet_Pro_7740_series";
      model = "drv:///hp/hpcups.drv/hp-officejet_pro_7740_series.ppd";
    }
  ];

  ensureDefaultPrinter = "HP_OfficeJet_Pro_7740";
};
}
