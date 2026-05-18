{pkgs, ...}: {
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
    (pkgs.callPackage ../../modules/scripts/changeAudioOutput.nix {})
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
}
