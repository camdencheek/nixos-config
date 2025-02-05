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

    # Entertainment Tools
    "vlc"
    "spotify"

    # Productivity Tools
    "raycast"
    "bitwarden"
    "jordanbaird-ice"
    "stats"
    "logseq"
    "notion-calendar"
    "logi-options+"

    # Browsers
    "google-chrome"
    "firefox@developer-edition"
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
