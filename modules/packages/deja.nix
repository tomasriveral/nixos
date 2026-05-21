{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
}:
buildGoModule (finalAttrs: {
  pname = "deja";
  version = "0.2.5";
  __structuredAttrs = true;
  src = fetchFromGitHub {
    owner = "Giammarco-Ferranti";
    repo = "deja";
    tag = "v${finalAttrs.version}";
    hash = lib.fakeHash;
  };

  vendorHash = "sha256-K4DOu3rfSlKAa5JNKCzWWpnWZlXXxtN5Po7p1Spqe1w=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${finalAttrs.version}"
  ];

  doCheck = true;

  nativeCheckInputs = [versionCheckHook];

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Predictive inline shell autosuggestions for zsh";
    homepage = "https://github.com/Giammarco-Ferranti/deja";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [tomasrivera];
    mainProgram = "deja";
  };
})
