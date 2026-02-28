{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    #font.name = nerd-fonts._0xproto;
    #font.size = "10";
    extraConfig = ''
font	nerd-fonts._0xproto
font_size	14
bold_font        auto
italic_font      auto
bold_italic_font auto
window_padding_width 25
foreground              #FFFFFF
background              #1B1D1C
selection_foreground    #1B1D1C
selection_background    #FFFFFF
cursor                  #C3AC76 
cursor_text_color       #0F1010

active_tab_foreground     #1B1D1C
active_tab_background     #6B5540
inactive_tab_foreground   #6B5540
inactive_tab_background   #1B1D1C

# black
color0      #29523D
color8      #578F73

# red
color1      #FFF0CC
color9      #F0DBAA

# green
color2      #FFEECC
color10     #F0D9AA

# yellow
color3      #FFE5CC
color11     #F0CCAA

# blue
color4      #9AE6C0
color12     #9AE6C0

# magenta
color5      #E6CC9A
color13     #E6CC9A

# cyan
color6      #E6BF9A
color14     #E6BF9A

# white
color7      #FFF0CC
color15     #F0DBAA
'';
};
}
