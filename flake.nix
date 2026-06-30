{
  description = "Nix config for Camden's macOS machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };
  outputs =
    {
      self,
      darwin,
      determinate,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      home-manager,
      nixpkgs,
    }@inputs:
    let
      locals = import ./locals.nix { };
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      mkApp = scriptName: {
        type = "app";
        program = "${
          (pkgs.writeScriptBin scriptName ''
            #!/usr/bin/env bash
            PATH=${pkgs.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/apps/${system}/${scriptName} "$@"
          '')
        }/bin/${scriptName}";
      };
      darwinSystem = darwin.lib.darwinSystem {
        inherit system;
        specialArgs = inputs // {
          inherit locals;
        };
        modules = [
          determinate.darwinModules.default
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              user = locals.username;
              enable = true;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = true;
              autoMigrate = true;
            };
          }
          ./hosts/darwin
        ];
      };
    in
    {
      devShells.${system}.default = with pkgs; mkShell {
        nativeBuildInputs = [
          bashInteractive
          git
        ];
        shellHook = ''
          export EDITOR=vim
        '';
      };

      apps.${system} = {
        build = mkApp "build";
        build-switch = mkApp "build-switch";
        rollback = mkApp "rollback";
      };

      darwinConfigurations.${system} = darwinSystem;
    };
}
