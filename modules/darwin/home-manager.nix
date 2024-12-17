{ config, pkgs, locals, ... }:

let
  user = locals.username;
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  darwinFiles = import ./files.nix { inherit config pkgs; };
in
{
  imports = [
   ./dock
   ../shared/locals.nix
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
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          darwinFiles
        ];

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  local = {
    dock = {
      enable = true;
      entries = [];
    };
  };
}
