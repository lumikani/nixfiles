{ config, pkgs, lib, ... }:
let
  exa_options_base = "--icons --git --time-style=long-iso -l";
  zsh_histdb_interactive = "$HOME/.config/zsh/plugins/zsh-histdb/histdb-interactive.zsh";
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

      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      dotDir = ".config/zsh"; 
      defaultKeymap = "viins";

      initExtra =
        ''
          # zsh-histdb
          autoload -Uz add-zsh-hook

          _zsh_autosuggest_strategy_histdb_top() {
            local query="
              select commands.argv from history
              left join commands on history.command_id = commands.rowid
              left join places on history.place_id = places.rowid
              where commands.argv LIKE '$(sql_escape $1)%'
              group by commands.argv, places.dir
              order by places.dir != '$(sql_escape $PWD)', count(*) desc
              limit 1
            "
              suggestion=$(_histdb_query "$query")
          }

          ZSH_AUTOSUGGEST_STRATEGY=histdb_top

          if [[ -f ${zsh_histdb_interactive} ]]; then
            source ${zsh_histdb_interactive}
            bindkey "^r" _histdb-isearch
          fi

          bindkey -v
          bindkey "^?" backward-delete-char

          # does not work in session variables for some reason
          export ZSH_HIGHLIGHT_STYLES[path]=none;
        '';

      sessionVariables = {
        EDITOR = "nvim";
        KEYTIMEOUT = "2";
        FZF_DEFAULT_COMMAND = "rg --files --hidden";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#595959";
      };

      shellAliases = {
        update = "sudo nixos-rebuild switch --flake .#";

        # exa aliases
        l = "exa ${exa_options_base}";
        ll = "exa ${exa_options_base}";
        la = "exa ${exa_options_base} -a";
        lt = "exa ${exa_options_base} -T --level 2";

        # git aliases;
        ga = "git add";
        gc = "git commit";
        gcm = "git commit --amend";
        gcp = "git cherry-pick";
        gp = "git push";
        gs = "git status";
        gsw = "git switch";
        gd = "git diff";
        gl = "git log";
        gpsup = "git push --set-upstream origin $(git_current_branch)";
        grb = "git rebase";
        grba = "git rebase --abort";
        grbc = "git rebase --continue";
        grbi = "git rebase --interactive";
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
