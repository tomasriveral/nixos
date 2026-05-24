{self, ...}: {
  perSystem = {pkgs, ...}: let
    inherit (self) pkgs-unstable;
  in {
    # perSystem doesnt like pkgs-unstable we must input it globally
    packages.dejaManuallyDerived = pkgs-unstable.buildGoModule (finalAttrs: {
      pname = "deja";
      version = "0.2.6";
      __structuredAttrs = true;
      src = pkgs.fetchFromGitHub {
        owner = "Giammarco-Ferranti";
        repo = "deja";
        tag = "v${finalAttrs.version}";
        hash = "sha256-xxbClKhhSwo+jUjAZ2gS4yOS5sSI76dfPpDzA3qdV18=";
      };

      vendorHash = "sha256-KmLdMK94cGOXMPJwWS6NgLB5OiNmJbszHdnLzauqJm8=";

      ldflags = [
        "-s"
        "-w"
        "-X main.version=${finalAttrs.version}"
      ];

      doCheck = true;

      nativeCheckInputs = [pkgs.versionCheckHook];

      passthru.updateScript = pkgs.nix-update-script {};

      meta = {
        description = "Predictive inline shell autosuggestions for zsh";
        homepage = "https://github.com/Giammarco-Ferranti/deja";
        license = pkgs.lib.licenses.mit;
        platforms = pkgs.lib.platforms.unix;
        maintainers = with pkgs.lib.maintainers; [tomasrivera];
        mainProgram = "deja";
      };
    });
  };
}
