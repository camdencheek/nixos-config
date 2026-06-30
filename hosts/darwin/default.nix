{
  agenix,
  config,
  pkgs,
  locals,
  ...
}:

{
  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin
    agenix.darwinModules.default
  ];

  # Let Determinate Nix manage the Nix installation, daemon, and nix.conf.
  determinateNix = {
    enable = true;
    customSettings = {
      trusted-users = [
        "@admin"
        "${locals.username}"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [ 
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      max-jobs = "auto";
      cores = 0; # Use all available cores
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Fix for nixbld group ID mismatch
  ids.gids.nixbld = 350;

  # Load package configuration
  environment.systemPackages = (import ../../modules/darwin/packages.nix { inherit pkgs; });

  # Enable Sourcegraph-specific configuration if necessary
  my.sourcegraph.enable = locals.tags.work;

  system = {
    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # Lower is faster.
        KeyRepeat = 2;

        # Lower is shorter delay before repeat starts.
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.swipescrolldirection" = false;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };
    };

    activationScripts.postActivation.text = ''
      echo "configuring live key repeat..." >&2
      /usr/bin/hidutil property --set '{"HIDKeyRepeat":33333333,"HIDInitialKeyRepeat":250000000}' > /dev/null

      echo "configuring default browser..." >&2
      launchctl asuser "$(id -u -- ${locals.username})" sudo --user=${locals.username} --set-home /usr/bin/osascript -l JavaScript -e 'ObjC.import("CoreServices"); $.LSSetDefaultHandlerForURLScheme($("http"), $("org.mozilla.firefoxdeveloperedition")); $.LSSetDefaultHandlerForURLScheme($("https"), $("org.mozilla.firefoxdeveloperedition")); undefined'
    '';
  };

  # nix-darwin applies this mapping during activation, but macOS clears
  # hidutil UserKeyMapping on reboot. Reapply it at login and periodically
  # in case macOS resets it during early login or keyboard reconnects.
  launchd.user.agents.caps-lock-to-control.serviceConfig = {
    ProgramArguments = [
      "/usr/bin/hidutil"
      "property"
      "--set"
      ''{"UserKeyMapping":${builtins.toJSON config.system.keyboard.userKeyMapping}}''
    ];
    RunAtLoad = true;
    StartInterval = 60;
  };

  # Configure and auto-start Redis
  services.redis = {
    enable = true;
    package = pkgs.redis;
  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
