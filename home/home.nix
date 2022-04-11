{ config, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Lumi";
      userEmail = "lumicake@pm.me";
    };
    zsh = {
      enable = true;

      sessionVariables = {
        EDITOR = "nvim";
      };

      "oh-my-zsh" = {
        enable = true;
        plugins = [
          "vi-mode"
          "systemd"
        ];
      };
    };
  };

  home.stateVersion = "21.11";
}
