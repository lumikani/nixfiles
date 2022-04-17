{ config, pkgs, lib, ... }:
{ 
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh"; 
      defaultKeymap = "viins";
      
      sessionVariables = {
        EDITOR = "nvim";
      };
      
      plugins = [
        {
	  name = "powerlevel10k-config";
	  src = lib.cleanSource ./.;
	  file = "p10k-config.zsh";
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
