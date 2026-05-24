Used for custom package derivation or for scripts.

For example, to use a newer package version that is still not in nixpkgs-unstable.

Some rules about package naming:
* If it is a custom derivation of a package, end with `ManuallyDerived`
* If it is a script, start with `custom-`. The executable, package name (and file name if it is the only thing in this nix file) must be equal.


If perSystem needs `pkgs-unstable` pass it manually with
```
{ self, ... }: {
  perSystem = { pkgs, ...}:
  let
    pkgs-unstable = self.pkgs-unstable;
  in
```
