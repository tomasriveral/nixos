{ ... }:
{
  flake.packages.custom-syllabes = { pkgs, ... }:
  # counts how many syllabes in a string.
  # not perfect. Does not handle silents e in french
  # but that's what I use for writing poetry
  pkgs.writers.writePython3Bin "custom-syllabes" {
    libraries = with pkgs; [
      python3Packages.pyphen
    ];
  } ''
    import sys
    import pyphen
  
    dic = pyphen.Pyphen(lang="fr")
  
    text = sys.stdin.read().strip()
  
    chunks = []
    total = 0
  
    for w in text.split():
        hyphenated = dic.inserted(w)
        parts = hyphenated.split("-")
        chunks.append("/".join(parts))
        total += len(parts)
  
    print(f"{total} ({'/'.join(chunks)})")
  '';
}
