{ config, pkgs, ... }:
let
  theme-tokyo-night = {
    primary = {
      background = "0x1a1b26";
      foreground = "0xa9b1d6";
    };
    normal = {
      black = "0x32344a";
      red = "0xf7768e";
      green = "0x9ece6a";
      yellow = "0xe0af68";
      blue = "0x7aa2f7";
      magenta = "0xad8ee6";
      cyan = "0x449dab";
      white = "0x787c99";
    };
    bright = {
      black = "0x444b6a";
      red = "0xff7a93";
      green = "0xb9f27c";
      yellow = "0xff9e64";
      blue = "0x7da6ff";
      magenta = "0xbb9af7";
      cyan = "0x0db9d7";
      white = "0xacb0d0";
    };
  };
  # Tokyo Night Storm (https://github.com/zatchheems/tokyo-night-alacritty-theme/blob/main/tokyo-night.yaml)
  theme-tokyo-night-storm = {
    primary = {
      background = "0x24283b";
      foreground = "0xa9b1d6";
    };
    normal = {
      black = "0x32344a";
      red = "0xf7768e";
      green = "0x9ece6a";
      yellow = "0xe0af68";
      blue = "0x7aa2f7";
      magenta = "0xad8ee6";
      cyan = "0x449dab";
      white = "0x9699a8";
    };
    bright = {
      black = "0x444b6a";
      red = "0xff7a93";
      green = "0xb9f27c";
      yellow = "0xff9e64";
      blue = "0x7da6ff";
      magenta = "0xbb9af7";
      cyan = "0x0db9d7";
      white = "0xacb0d0";
    };
  };
  # iTerm theme (https://github.com/eendroroy/alacritty-theme/blob/master/themes/iterm.yaml)
  theme-iterm = {
    primary = {
      background = "0x101421";
      foreground = "0xfffbf6";
    };
    normal = {
      black = "0x2e2e2e";
      red = "0xeb4129";
      green = "0xabe047";
      yellow = "0xf6c744";
      blue = "0x47a0f3";
      magenta = "0x7b5cb0";
      cyan = "0x64dbed";
      white = "0xe5e9f0";
    };
    bright = {
      black = "0x565656";
      red = "0xec5357";
      green = "0xc0e17d";
      yellow = "0xf9da6a";
      blue = "0x49a4f8";
      magenta = "0xa47de9";
      cyan = "0x99faf2";
      white = "0xffffff";
    };
  };
  theme-dracula = {
    primary = {
      background = "0x282a36";
      foreground = "0xf8f8f2";
    };
    normal = {
      black = "0x000000";
      red = "0xff5555";
      green = "0x50fa7b";
      yellow = "0xf1fa8c";
      blue = "0xbd93f9";
      magenta = "0xff79c6";
      cyan = "0x8be9fd";
      white = "0xbbbbbb";
    };
    bright = {
      black = "0x555555";
      red = "0xff5555";
      green = "0x50fa7b";
      yellow = "0xf1fa8c";
      blue = "0xcaa9fa";
      magenta = "0xff79c6";
      cyan = "0x8be9fd";
      white = "0xffffff";
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Iosevka Term";
          style = "Regular";
        };
        size = 10;
      };

      colors = theme-tokyo-night;
    };
  };
}
