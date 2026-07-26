{inputs, ...}: {
  flake.nixosModules.agenix = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.agenix.packages.${pkgs.system}.default
    ];
  age.identityPaths = [
    "/home/tomasr/.ssh/id_ed25519"
  ];
    age.secrets.ntfy = {
      file = ../../secrets/ntfy.age;
      owner = "tomasr";
      group = "users";
      mode = "0400";
    };
  };
}
