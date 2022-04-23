{ config, pkgs, lib, ... }:
let
  mode_system = "(l)ock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown";
  lock_system = "i3lock && sleep 1";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modes = lib.mkOptionDefault {
        "${mode_system}" = {
          l = "exec --no-startup-id ${lock_system}, mode \"default\"";
          e = "exec --no-startup-id i3-msg exit, mode \"default\"";
	  s = "exec --no-startup-id ${lock_system} && systemctl suspend, mode \"default\"";
	  h = "exec --no-startup-id ${lock_system} && systemctl suspend, mode \"default\"";
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
	size = 14.0;
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
	"${modifier}+Shift+e" = "exec 'i3-nagbar -t warning -m \'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.\' -B \'Yes, exit i3\' \'xfce4-session-logout\'";
        "${modifier}+Shift+b" = "mode \"${mode_system}\"";
      };

      modifier = "Mod4";
      
      terminal = "alacritty";

      workspaceAutoBackAndForth = true;
    };
  };
}

