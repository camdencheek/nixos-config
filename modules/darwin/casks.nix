{ lib, locals, ... }:

let
  default = [
    # Communication Tools
    "discord"
    "slack"
    "zoom"
    "whatsapp"
    "kitty"
    "ghostty"

    # Productivity Tools
    "bitwarden"
    "jordanbaird-ice"
    "stats"
    "logseq"
    "notion-calendar"
    "logi-options+"
    "monitorcontrol"
    "cleanshot"
    "superwhisper"
		"raycast"
    "firefox@developer-edition"

    # Other
    "betterdisplay"
    "gimp"
    "inkscape"
    "tailscale"
  ];
  # Sourcegraph-specific casks moved to sourcegraph.nix
  personal = [
    "steam"
    "qbittorrent"
  ];
in
lib.unique (
  default
  # Sourcegraph casks managed by sourcegraph.nix module
  ++ (lib.optionals locals.tags.personal personal)
)
