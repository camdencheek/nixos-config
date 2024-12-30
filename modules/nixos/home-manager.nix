{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "ccheek";
  shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
  shared-files = import ../shared/files.nix { inherit config pkgs; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix { };
    file = shared-files;
    stateVersion = "21.05";
  };

  programs = shared-programs // {
    gpg.enable = true;
  };

}
