{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    file
    wget   
    firefox
    btop
    gdu
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
    docker
    transmission
    unzip
    ripgrep
    arcanPackages.espeak
  ];
}

