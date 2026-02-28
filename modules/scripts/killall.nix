{ writeShellApplication, hyprland, jq,... }:

writeShellApplication {
	name = "custom-killall";
	runtimeInputs = [
		hyprland
		jq
	];
	text = ''
  active_workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')

  hyprctl clients -j |
    jq -r ".[] 
      | select(.workspace.id==''${active_workspace_id}) 
      | select(.focusHistoryID!=0) 
      | .pid" |
    xargs -r kill
'';
}
