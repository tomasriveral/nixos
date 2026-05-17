{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  programs.nix-ld.enable = true; #Run unpatched dynamic binaries on NixOS. For example lets run ./a.out from gcc
  environment.systemPackages = with pkgs; [
    gcc
    jq # json parser used in some scripts
    jp # lightweight and flexible cli JSON parser
    (pkgs-unstable.python314.withPackages (ps:
      with ps; [
        matplotlib
        networkx
        scipy
      ]))
    python313Packages.pygments # used for ccat (comment of colorize plugin from oh-my-zsh)
        pkg-config
    gdb
    raylib
    glfw # raylib and some dependecies

    direnv
    cling # c interpreter used for coding
    # lsp
    clang-tools
    python311Packages.python-lsp-server
    ltex-ls-plus
    pylint
    black
  ];
}
