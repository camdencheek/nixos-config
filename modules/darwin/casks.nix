{ lib, locals, ... }:

let
  default = [
    # Communication Tools
    "discord"
    "slack"
    "whatsapp"
    "ghostty"

    # Productivity Tools
    "bitwarden"
	 "google-chrome"
	 "bruno"
    # "jordanbaird-ice"
    "stats"
    "notion-calendar"
    "cleanshot"
	 "raycast"
    "firefox@developer-edition"
	 "spotify"
	 "telegram"
	 "voiceink"
	 "uhk-agent"

    # Other
    # "betterdisplay"
    "tailscale-app"
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
