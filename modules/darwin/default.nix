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
    overlays = [
      (final: prev: {
        mise = final.stdenvNoCC.mkDerivation {
          pname = "mise";
          version = "2026.6.14";

          src = final.fetchurl {
            url = "https://github.com/jdx/mise/releases/download/v2026.6.14/mise-v2026.6.14-macos-arm64";
            hash = "sha256-L3Ck338S1QImw0uFeCHID5EbOCWYzz95cunQ3uBwa7k=";
          };

          dontUnpack = true;

          installPhase = ''
            runHook preInstall
            install -Dm755 $src $out/bin/mise
            mkdir -p $out/lib/mise
            touch $out/lib/mise/.disable-self-update
            runHook postInstall
          '';

          meta = prev.mise.meta;
        };
      })
    ];

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
