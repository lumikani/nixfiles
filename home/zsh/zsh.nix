{ config, pkgs, lib, ... }:
let
  exa_options_base = "--icons --git --time-style=long-iso -l";
in
{ 
  home.packages = with pkgs; [
    sqlite
  ];

  programs = {
    zoxide = {
      enable = true;
      options = [
        "--cmd j"
      ];
    };

    exa = {
      enable = true;
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh"; 
      defaultKeymap = "viins";

      initExtra =
        ''
          # zsh-histdb
          autoload -Uz add-zsh-hook
        '';
      
      sessionVariables = {
        EDITOR = "nvim";
      };

      shellAliases = {
        update = "sudo nixos-rebuild switch --flake .#";

        # exa aliases
        ll = "exa ${exa_options_base}";
        la = "exa ${exa_options_base} -a";
        lt = "exa ${exa_options_base} -T --level 2";
      };
      
      plugins = [
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./.;
          file = "p10k-config.zsh";
        }
        {
          name = "zsh-histdb";
          src = pkgs.fetchFromGitHub {
            owner = "larkery";
            repo = "zsh-histdb";
            rev = "30797f0c50c31c8d8de32386970c5d480e5ab35d";
            sha256 = "sha256-PQIFF8kz+baqmZWiSr+wc4EleZ/KD8Y+lxW2NT35/bg=";
          };
        }
      ];
      
      zplug = {
        enable = true;
        plugins = [
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
    };
  };
}
