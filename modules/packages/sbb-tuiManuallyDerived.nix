{ ... }: {
  perSystem = { pkgs, pkgs-unstable, ... }: {
  packages.sbb-tuiManuallyDerived = pkgs-unstable.buildGoModule (finalAttrs: {
    pname = "sbb-tui";
    version = "1.14.2";
    __structuredAttrs = true;
    src = pkgs.fetchFromGitHub {
      owner = "Necrom4";
      repo = "sbb-tui";
      tag = "v${finalAttrs.version}";
      hash = pkgs.lib.fakeHash;
    };
  
    vendorHash = "sha256-K4DOu3rfSlKAa5JNKCzWWpnWZlXXxtN5Po7p1Spqe1w=";
  
    ldflags = [
      "-s"
      "-w"
      "-X main.version=${finalAttrs.version}"
    ];
  
    allowGoReference = true;
  
    doCheck = true;
  
    nativeCheckInputs = [pkgs.versionCheckHook];
  
    passthru.updateScript = pkgs.nix-update-script {};
  
    meta = {
      description = "TUI client for Switzerland's public transport timetables, inspired by SBB/CFF/FFS app";
      homepage = "https://github.com/Necrom4/sbb-tui";
      license = pkgs.lib.licenses.mit;
      platforms = pkgs.lib.platforms.unix;
      maintainers = with pkgs.lib.maintainers; [tomasrivera];
      mainProgram = "sbb-tui";
    };
  });
}; }
