{ config, pkgs, lib, ... }:
{
  programs.mpv = {
    enable = true;

    config = {
      slang = "en";
      alang = "fi,en";

      sub-file-paths = "subs:sub:subtitles";
      sub-auto = "fuzzy";
      fs = true;
      save-position-on-quit = true;
      keep-open = "yes";
      sub-filter-jsre-append = "OpenSubtitles|awaqeded|Clearway Law|osdb\\.link";
    };
  };
}
