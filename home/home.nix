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

  home.packages = with pkgs; [
    tig
  ];

  home.file.".tigrc".text =
    ''
      set main-view = author:yes date:no id:yes commit-title:yes
      bind generic 9 @sh -c "printf '%s' %(commit) | xclip -selection c"
    '';

  home.stateVersion = "21.11";
}
