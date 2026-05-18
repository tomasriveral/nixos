{pkgs-unstable, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama-vulkan;
    #port = 11434;
    #host = "127.0.0.1:11434";
    # loadModels load them directly into ram at startup. Doesn't download them.
    #loadModels = [ "mistral:7b" ]; # don't forget the :xxxxx for ex: "mixtral" don't work
    #syncModels =  true;
  };
  systemd.services.ollama.serviceConfig.ExecStartPost = [
    # use this to auto download models
    "${pkgs-unstable.ollama-vulkan}/bin/ollama pull mistral:7b"
  ];
  /*
    services.open-webui = {
    enable = true;
    port = 8080;
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "True";
    };
  };
  */
}
