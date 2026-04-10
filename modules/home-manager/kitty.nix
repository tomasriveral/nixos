{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    #font.name = nerd-fonts._0xproto;
    #font.size = "10";
    ## new config (matches with caelestia
    ## old condfig
    extraConfig = ''
      font_size 14
bold_font auto
italic_font auto
bold_italic_font auto

window_padding_width 25

# --- Core ---
foreground #ece0d9
background #18120e

selection_foreground #18120e
selection_background #ece0d9

cursor #ffb878
cursor_text_color #18120e

# --- Tabs ---
active_tab_foreground #18120e
active_tab_background #5c412a
inactive_tab_foreground #d6c3b5
inactive_tab_background #241e1a

# --- Black / Gray ---
color0  #353433
color8  #b29f91

# --- Red ---
color1  #e17300
color9  #ff8a20

# --- Green ---
color2  #ffc071
color10 #ffd6a8

# --- Yellow ---
color3  #ffe0c6
color11 #fff2e8

# --- Blue ---
color4  #b9ab66
color12 #d7be91

# --- Magenta ---
color5  #ed9562
color13 #fcad7e

# --- Cyan ---
color6  #f4c16d
color14 #ffd497

# --- White ---
color7  #ebd4c1
color15 #FFFFFF
      '';
    /*extraConfig = ''
      # font	nerd-fonts._0xproto # this key dont work and causes errors
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
      #color1      #FFF0CC
      #color9      #F0DBAA
      # we need actual red colors
      color1       #CC241D
      color9       #9D0006

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
    '';*/
  };
}
