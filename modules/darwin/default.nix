{
  config,
  locals,
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
  system.primaryUser = locals.username;

  system.activationScripts.postActivation.text = ''
    echo "refreshing LaunchServices for Nix apps..." >&2
    lsregister=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister
    systemApps='${config.system.build.applications}/Applications'
    nixApps='/Applications/Nix Apps'

    if [ -x "$lsregister" ] && [ -d "$systemApps" ]; then
      /usr/bin/find "$systemApps" -maxdepth 1 -type l -name '*.app' -print0 | while IFS= read -r -d ''' appLink; do
        appTarget=$(readlink "$appLink" || true)
        if [[ "$appTarget" == /nix/store/*/Applications/*.app ]]; then
          "$lsregister" -u "$appTarget" >/dev/null 2>&1 || true
        fi
      done

      if [ -d "$nixApps" ]; then
        /usr/bin/find "$nixApps" -maxdepth 1 -name '*.app' -print0 | while IFS= read -r -d ''' app; do
          "$lsregister" -f "$app" >/dev/null 2>&1 || true
        done
      fi
    fi
  '';
}
