{ config, pkgs, ... }:
{
  imports = [
    ./zsh/zsh.nix
    ./alacritty.nix
    ./i3.nix
    ./firefox.nix
    ./nvim.nix
  ];

  programs = {
    git = {
      enable = true;
      userName = "Lumi";
      userEmail = "lumicake@pm.me";
    };
  }; 

  home.stateVersion = "21.11";
}
