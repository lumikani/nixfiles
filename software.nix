{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget   
    firefox
    git 
    btop
    networkmanagerapplet
    nix-prefetch-scripts
    which   
    progress
    jq 
    mpv
    signal-desktop
    discord
    docker-compose
    tdesktop
    spotify
    slack 
    neovim
    anki  
    docker
    transmission
  ];
}

