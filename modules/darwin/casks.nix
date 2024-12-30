{ lib, locals, ... }:

let
  default = [
    # Development Tools
    "homebrew/cask/docker"
    "zed"
    "wezterm"
    "ghostty"
    "bruno"
    "burp-suite"
    "ollama"
    "proxyman"

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
    "bartender"
    "stats"
    "logseq"
    "notion-calendar"

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
  ];
  personal = [
    "steam"
  ];
in
lib.unique (
  default
  ++ (lib.optionals locals.tags.work sourcegraph)
  ++ (lib.optionals locals.tags.personal personal)
)
