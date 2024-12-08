{ config, pkgs, lib, ... }:

let name = "Camden Cheek";
    user = "ccheek";
    email = "camden@ccheek.com"; in
{
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
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi
    '';
    initExtra = builtins.readFile ./config/zsh/zshrc;
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
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
}
