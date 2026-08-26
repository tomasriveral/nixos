{inputs, ...}: {
  flake.nixosModules.agenix = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.agenix.packages.${pkgs.system}.default
      pkgs.age
    ];
    age.identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    age.secrets.ntfy = {
      file = ../../secrets/ntfy.age;
      owner = "tomasr";
      group = "users";
      mode = "0400";
    };
    age.secrets.epfl = {
      file = ../../secrets/epfl.age;
      owner = "tomasr";
      group = "users";
      mode = "0400";
    };
  };
}
