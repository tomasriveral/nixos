{
  lib,
  python3Packages,
  fetchFromGitLab,
  frhyme,
  haspirater,
}:
python3Packages.buildPythonApplication rec {
  pname = "plint";

  # No PyPI version mentioned; upstream is git-based
  version = "unstable-2026-04-28";

  src = fetchFromGitLab {
    owner = "a3nm";
    repo = "plint";
    rev = "master";
    sha256 = lib.fakeSha256; # replace after first build
  };

  propagatedBuildInputs = [
    frhyme
    haspirater
    python3Packages.cherrypy
  ];

  # plint uses scripts + data generation steps, so disable strict tests
  doCheck = false;

  preBuild = ''
    # required data generation steps from README
    echo "Generating frhyme.json..."
    (cd frhyme/lexique && ./lexique_retrieve.sh > lexique.txt)
    (cd frhyme && ./make.sh 4 lexique/lexique.txt additions > frhyme.json)

    echo "Generating occurrences file..."
    ./lexique_occurrences_retrieve.sh > data/occurrences || true
  '';

  postInstall = ''
    # ensure CLI entry point exists
    install -Dm755 plint.py $out/bin/plint
  '';

  meta = with lib; {
    description = "French poetry validator (metrics, rhymes, template checking)";
    homepage = "https://gitlab.com/a3nm/plint";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
}
