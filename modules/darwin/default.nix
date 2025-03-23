{ config, lib, pkgs, ... }:

{
  imports = [
    ./home-manager.nix
  ];
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };
}
