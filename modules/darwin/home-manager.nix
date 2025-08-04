{
  config,
  pkgs,
  locals,
  ...
}:

let
  user = locals.username;
  files = import ./files.nix { inherit config pkgs; };
in
{
  imports = [
    ./dock
    ./locals.nix
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
    };
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
          packages = pkgs.callPackage ./packages.nix { };
          file = files;
          stateVersion = "23.11";
        };

        programs = {
          # Documented here: https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
          zsh = {
            enable = true;
            plugins = [
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
            dotDir = ".config/zsh";
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

          ssh = {
            enable = true;
            includes = [
              "/Users/${user}/.ssh/config_external"
            ];
            matchBlocks = {
              "github.com" = {
                identitiesOnly = true;
                identityFile = [
                  "/Users/${user}/.ssh/id_github"
                ];
              };
            };
          };
        };

        # Marked broken Oct 20, 2022 check later to remove this
        # https://github.com/nix-community/home-manager/issues/3344
        manual.manpages.enable = false;
      };
  };
}
