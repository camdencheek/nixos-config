{ pkgs, locals, ... }:

let
  user = locals.username;
  files = import ./files.nix;
in
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall"; # Remove Homebrew packages not declared in this config
      upgrade = false; # Skip automatic upgrades to speed up rebuilds
    };
    brews = [ ];
    casks = pkgs.callPackage ./casks.nix { inherit locals; };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          file = files { inherit config lib; };
          stateVersion = "23.11";
        };

        programs = {
          atuin = {
            enable = true;
            enableZshIntegration = true;
            settings = {
              update_check = false;
              search_mode = "fulltext";
              filter_mode = "host";
              preload = true;
            };
          };

          # Documented here: https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
          zsh = {
            enable = true;
            plugins = [
              {
                name = "zsh-async";
                src = pkgs.fetchFromGitHub {
                  owner = "mafredri";
                  repo = "zsh-async";
                  rev = "v1.8.6";
                  sha256 = "sha256-Js/9vGGAEqcPmQSsumzLfkfwljaFWHJ9sMWOgWDi0NI=";
                };
                file = "async.zsh";
              }
              {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
              }
              {
                name = "powerlevel10k-config";
                src = lib.cleanSource ./config;
                file = "p10k.zsh";
              }
            ];

            initContent = ''
              if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
                . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
                . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
              fi
            '' + builtins.readFile ./config/zsh/zshrc;
            autocd = false;
            dotDir = "${config.xdg.configHome}/zsh";
            defaultKeymap = "emacs";
            shellAliases = {
              ls = "eza";

              # Git aliases
              gap = "git add --patch";
              gl = "git pull";
              gp = "git push --set-upstream origin";
              gpu = "git push --set-upstream origin HEAD:refs/heads/cc/$(git rev-parse --abbrev-ref HEAD)";
              gco = "git checkout";
              gs = "git status -sb";
              gac = "git add -A && git commit -m";
              gcl = "git clean -d -f";
            };
            history = {
              append = true;
              path = "${config.xdg.dataHome}/zsh/zsh_history";
              ignoreDups = false;
              ignoreAllDups = true;
              ignoreSpace = false;
              extended = true;
              share = true;
            };
          };
        };

        # Marked broken Oct 20, 2022 check later to remove this
        # https://github.com/nix-community/home-manager/issues/3344
        manual.manpages.enable = false;

        launchd.agents.syncthing = {
          enable = true;
          config = {
            Label = "org.nixos.syncthing";
            ProgramArguments = [ "${pkgs.syncthing}/bin/syncthing" "serve" "--no-browser" ];
            KeepAlive = true;
            RunAtLoad = true;
            ProcessType = "Background";
            StandardOutPath = "${config.home.homeDirectory}/Library/Logs/syncthing.log";
            StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/syncthing.log";
          };
        };
      };
  };
}
