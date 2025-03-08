{ lib, locals, ... }:

let
  default = [
    # Development Tools
    "zed"
    "wezterm"
    "ghostty"
    "bruno"
    "burp-suite"
    "ollama"
    "proxyman"
    "tuple"

    # Communication Tools
    "discord"
    "slack"
    "telegram"
    "zoom"
    "whatsapp"

    # Entertainment Tools
    "vlc"
    "spotify"

    # Productivity Tools
		"claude"
    "raycast"
    "bitwarden"
    "jordanbaird-ice"
    "stats"
    "logseq"
    "notion-calendar"
    "logi-options+"
    "mullvadvpn"
    "monitorcontrol"
    "uhk-agent"

    # Browsers
    "google-chrome"
    "firefox@developer-edition"
		"firefox"

    # Other
    "gimp"
  ];
  sourcegraph = [
    "linear-linear"
    "cleanshot"
    "visual-studio-code"
    "figma"
    "notion"
    "postgres-unofficial"
    "perforce"
  ];
  personal = [
    "steam"
    "qbittorrent"
  ];
in
lib.unique (
  default
  ++ (lib.optionals locals.tags.work sourcegraph)
  ++ (lib.optionals locals.tags.personal personal)
)
