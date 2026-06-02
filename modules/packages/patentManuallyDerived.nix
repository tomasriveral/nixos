_: {
  perSystem = {pkgs, ... }: {
  packages.patent = {lib, rustPlatform, fetchFromGitHub, ...}: rustPlatform.buildRustPackage (finalAttrs: {
  pname = "patent";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "r14dd";
    repo = "patent";
    rev = "v${finalAttrs.version}";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Prior-art search for code ideas across open-source registries";
    homepage = "https://github.com/r14dd/patent";
    license = with licenses; [ mit asl20 ];
    maintainers = [ ];
    platforms = platforms.all;
    mainProgram = "patent";
  };
});
};}

