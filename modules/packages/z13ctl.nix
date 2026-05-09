{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "z13ctl";
  version = "1.1.6";

  src = fetchFromGitHub {
    owner = "dahui";
    repo = "z13ctl";
    rev = "v1.1.6";
    hash = "sha256-21mdAzbw8JISDLG7iSEI4VCephDTtbioN0/RRxvCLR8=";
  };

  vendorHash = "sha256-ftkcianIR36PNAoMOVuk4lUr7goWUcHhjyNseUraJU0=";

  subPackages = [ "." ];

  __structuredAttrs = true;

  meta = with lib; {
    description = "Utility for ASUS ROG Flow Z13 (2025)";
    homepage = "https://github.com/dahui/z13ctl";
    license = licenses.asl20;
    platforms = platforms.linux;
    mainProgram = "z13ctl";
    maintainers = with maintainers; [ badheuristic ];
  };
}
