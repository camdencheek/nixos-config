{
  description = "Nix config for Camden's macOS machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
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
    localConfig = {
      url = "/Users/ccheek/nixos-config/locals.nix";
      flake = false;
    };
  };
  outputs =
    {
      self,
      darwin,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      home-manager,
      nixpkgs,
      agenix,
      localConfig,
    }@inputs:
    let
      locals = import localConfig { };
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      mkApp = scriptName: {
        type = "app";
        program = "${
          (pkgs.writeScriptBin scriptName ''
            #!/usr/bin/env bash
            PATH=${pkgs.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/apps/${system}/${scriptName}
          '')
        }/bin/${scriptName}";
      };
      mkDarwinSystem = sourcegraph: darwin.lib.darwinSystem {
        inherit system;
        specialArgs = inputs // {
          locals = if sourcegraph then locals // { sourcegraph = true; } else locals;
        };
        modules = [
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
          age
          age-plugin-yubikey
        ];
        shellHook = ''
          export EDITOR=vim
        '';
      };

      apps.${system} = {
        "apply" = mkApp "apply";
        "build" = mkApp "build";
        "build-switch" = mkApp "build-switch";
        "copy-keys" = mkApp "copy-keys";
        "create-keys" = mkApp "create-keys";
        "check-keys" = mkApp "check-keys";
        "rollback" = mkApp "rollback";

        # Sourcegraph config apps
        "build-sourcegraph" = {
          type = "app";
          program = "${
            (pkgs.writeScriptBin "build-sourcegraph" ''
              #!/usr/bin/env bash
              PATH=${pkgs.git}/bin:$PATH
              echo "Building Sourcegraph config for ${system}"
              nix build ".#darwinSourcegraphConfigurations.${system}.system"
            '')
          }/bin/build-sourcegraph";
        };
        "apply-sourcegraph" = {
          type = "app";
          program = "${
            (pkgs.writeScriptBin "apply-sourcegraph" ''
              #!/usr/bin/env bash
              PATH=${pkgs.git}/bin:$PATH
              echo "Applying Sourcegraph config for ${system}"
              $(nix build --no-link --print-out-paths ".#darwinSourcegraphConfigurations.${system}.system")/sw/bin/darwin-rebuild switch --flake ".#darwinSourcegraphConfigurations.${system}"
            '')
          }/bin/apply-sourcegraph";
        };
      };

      darwinConfigurations.${system} = mkDarwinSystem false;
      darwinSourcegraphConfigurations.${system} = mkDarwinSystem true;
    };
}
