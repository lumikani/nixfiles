{ config, pkgs, lib, ... }:
let
  mode_system = "(l)ock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown";
  lock_system = "xflock4";
  i3status-bottom = "bottom";
  rofi-package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
  rofi-menu = "${rofi-package}/bin/rofi -show";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = [
        {
          fonts = {
            names = [ "Iosevka Term" ];
            size = 12.0;
          };
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-${i3status-bottom}.toml";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];

      modes = lib.mkOptionDefault {
        "${mode_system}" = {
          l = "exec --no-startup-id ${lock_system}, mode \"default\"";
          e = "exec --no-startup-id xfce4-session-logout, mode \"default\"";
          s = "exec --no-startup-id ${lock_system} && systemctl suspend, mode \"default\"";
          h = "exec --no-startup-id ${lock_system} && systemctl hibernate, mode \"default\"";
          r = "exec --no-startup-id systemctl reboot, mode \"default\"";
          "Shift+s" = "exec --no-startup-id systemctl reboot, mode \"default\"";
          Return = "mode \"default\"";
          Escape = "mode \"default\"";
	      };

        resize = {
          h = "resize shrink width 10 px or 10 ppt";
          j = "resize grow height 10 px or 10 ppt";
          k = "resize shrink height 10 px or 10 ppt";
          l = "resize grow width 10 px or 10 ppt";
        };
      };

      focus.followMouse = false;
      fonts = {
        names = [ "Iosevka Regular Term" ];
        size = 11.0;
      };

      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Ctrl+Shift+Right" = "move workspace to output right";
        "${modifier}+Ctrl+Shift+Left" = "move workspace to output left";
        "${modifier}+g" = "split h";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Escape" = "exec ${lock_system}";
        "${modifier}+Shift+e" = "exec 'i3-nagbar -t warning -m \'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.\' -B \'Yes, exit i3\' \'xfce4-session-logout\'";
        "${modifier}+Shift+b" = "mode \"${mode_system}\"";
        "${modifier}+space" = "exec ${rofi-menu} run";
        "Ctrl+space" = "exec ${rofi-menu} window";
        "${modifier}+period" = "exec ${rofi-menu} emoji";
      };

      menu = "${rofi-menu} run";

      modifier = "Mod4";
      
      terminal = "alacritty";

      workspaceAutoBackAndForth = true;
    };
  };

  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";

    package = rofi-package;

    extraConfig = {
        modi = "run,emoji,window";
    };
  };

  home.packages = with pkgs; [
    font-awesome_5 # needed by i3status-rust
  ];

  programs.i3status-rust = {
    enable = true;
    bars = {
      "${i3status-bottom}" = {
        blocks = [
          {
            block = "pomodoro";
            length = 25;
            break_length = 10;
            message = "✨ Focus timer done ✨";
            notifier = "i3nag";
            break_message = "✨ Chill timer done ✨";
          }
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used_percents}";
            format_swap = "{swap_used_percents}";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          { block = "sound"; }
          { 
            block = "battery";
            interval = 30;
            format = "{percentage} ({time})";
          }
          {
            block = "time";
            interval = 60;
            format = "%a %F %R";
          }
        ];
        icons = "awesome5";
        theme = "space-villain";
      };
    };
  };
}

