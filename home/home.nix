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
    slack
    dbeaver
  ];

  home.file = {
    ".xprofile".text = ''
      eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
      export SSH_AUTH_SOCK
    '';

    ".tigrc".text = ''
      set git-colors = no
      # Override the default terminal colors to white on black.
      # color default         white   black
      color   cursor          black   green
      color   search-result   black   yellow
      # color author          green   black
      # color status          green   black
      color   line-number     red     black
      color   title-focus     black   yellow
      color   title-blur      black   magenta
      # Diff colors
      color diff-header       yellow  default
      color diff-index        blue    default
      color diff-chunk        magenta default
      color "Reported-by:"    green   default
      # View-specific color
      color tree.date         black   cyan    bold

      set main-view = author:yes date:no id:yes commit-title:yes
      bind generic 9 @sh -c "printf '%s' %(commit) | xclip -selection c"
    '';
  };

  home.stateVersion = "21.11";
}
