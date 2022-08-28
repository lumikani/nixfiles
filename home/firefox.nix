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
     reddit-enhancement-suite
    ];

    profiles = {
      lumi = {
        id = 0;
        settings = {
          "browser.startup.page" = 3;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
            #TabsToolbar
            {
              visibility: collapse;
            }
          '';
      };
    };
  };
}

