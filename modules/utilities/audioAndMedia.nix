{ self, ... }: {
  flake.nixosModules.audioAndMedia = {pkgs, ...}: {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.system}.custom-changeAudioOutput
      kdePackages.okular
      kdePackages.dolphin
      pulseaudio # sound server
      playerctl # controls media player
      pavucontrol # PulseAudio Volume Control
      mplayer # Movie player that supports many video formats
      krita # image edition
      yt-dlp # some youtube downloader
      vlc
      #mprisence # Highly customizable Discord Rich Presence for MPRIS media players on Linux
      #gif-for-cli # Render gifs as ASCII art in your cli
      #rembg # background remover
      gpu-screen-recorder
      inkscape
    ];
    
    security.wrappers.gsr-kms-server = {
      # to remove the password prompt when using gpu-screen-recorder
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+ep";
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
    };
  };
    flake.packages.custom-changeAudioOutput = { pkgs, ...}:
    pkgs.writeShellApplication {
      name = "custom-changeAudioOutput";
      runtimeInputs = with pkgs; [
        fzf
        pulseaudio
        jq
      ];
      text = ''
        select=$(pactl -f json list sinks | jq -r '.[].name' | fzf)
        if [[ -n "$select" ]]; then
          pactl set-default-sink "$select"
        fi
        pkill -f "kitty.*Select audio output"
      '';
  };
}
