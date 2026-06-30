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

  personal = [
    "steam"
  ];
in
lib.unique (
  default
  ++ (lib.optionals locals.tags.personal personal)
)
