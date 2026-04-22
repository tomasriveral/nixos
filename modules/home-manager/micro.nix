{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  programs.micro = {
    enable = true;
    package = pkgs-unstable.micro-full;
    settings = {
    };
  };
  home.file.".config/micro/plug/vivify" = {
    enable = true;
    source = inputs.microPlugins-vivify;
    recursive = true;
    force = true;
  };
  home.file.".config/micro/init.lua" = {
    enable = true;
    force = true;
    text = ''
local buffer = import("micro/buffer")
local shell = import("micro/shell")

function vivifyOpen(buf)
    local cursor = buf:GetActiveCursor()
    local line = cursor.Loc.Y + 1

    shell.ExecCommand("viv", string.format("%s:%d", buf.AbsPath, line))
end

function onBufferOpen(buf)
    if os.getenv("MICRO_VIVIFY") ~= "1" then
        return
    end

    -- only run for real files (not help/log/etc)
    if buf.Type.Kind == buffer.BTDefault then
        vivifyOpen(buf)
    end
end
'';
  };
}
