{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    file
    wget   
    firefox
    btop
    gdu
    meld
    networkmanagerapplet
    nix-prefetch-scripts
    which   
    progress
    jq 
    signal-desktop
    discord-ptb
    docker-compose
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

