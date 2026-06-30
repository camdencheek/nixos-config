{ lib, locals, ... }:

let
  default = [
    # Productivity Tools without suitable nixpkgs replacements
    "bitwarden"
    "notion-calendar"
    "cleanshot"
    "voiceink"
    "uhk-agent"
    "tailscale-app"
  ];
  # Sourcegraph-specific casks moved to sourcegraph.nix
  personal = [
    "steam"
  ];
in
lib.unique (
  default
  # Sourcegraph casks managed by sourcegraph.nix module
  ++ (lib.optionals locals.tags.personal personal)
)
