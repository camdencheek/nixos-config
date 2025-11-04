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
	 "google-chrome"
	 "bruno"
    # "jordanbaird-ice"
    "stats"
    "notion-calendar"
    "logi-options+"
    "monitorcontrol"
    "cleanshot"
	 "raycast"
    "firefox@developer-edition"
	 "obsidian"
	 "spotify"
	 "telegram"
	 "docker"
	 "voiceink"
	 "uhk-agent"
	 "wezterm"
	 "meld"

    # Other
    # "betterdisplay"
    "gimp"
    "inkscape"
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
