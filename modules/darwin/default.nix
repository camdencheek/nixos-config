{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./home-manager.nix
    ./sourcegraph.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  # Set primary user for nix-darwin to support user-specific options
  system.primaryUser = "${config.locals.username}";
}
