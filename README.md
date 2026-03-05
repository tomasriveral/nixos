# NixOS configuration
![NixOS configuraton](/assets/example.png)
###  Installation guide
You need to have `git` installed before installing the config.
```shell
cd
git clone https://github.com/Totorile1/nixos.git
cd ./nixos
sudo nixos-rebuild switch --flake ~/nixos/#laptop
```

### Things that don't work reliably and need manual setting.
- Some Librewolf's extension's settings, such as SponsorBlock
- Librewolf's bookmarks
