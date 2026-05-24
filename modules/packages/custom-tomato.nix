_: {
  perSystem = {pkgs, ...}: {
    packages.custom-tomato = pkgs.writeShellApplication {
      name = "custom-tomato";
      runtimeInputs = with pkgs; [
        kitty
        tomato-c
      ];
      text = ''
        kitty --class "custom-pomodoro" --name "custom-pomodoro" -e tomato
      '';
    };
  };
}
