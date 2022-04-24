{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
     ublock-origin
     darkreader
     betterttv
     https-everywhere
     i-dont-care-about-cookies
     privacy-badger
     sidebery
     vimium
     tokyo-night-v2
    ];

    profiles = {
      lumi = {
        id = 0;
        settings = {
          "browser.startup.page" = 3;
        };
      };
    };
  };
}

