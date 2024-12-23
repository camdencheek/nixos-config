{lib, config, locals, ...}:

let
    default =  [
        # Development Tools
        "homebrew/cask/docker"
        "zed"
        "wezterm"
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
    ];
    personal = [
      "steam"
    ];
in
  lib.unique (
  default ++
  (lib.optionals locals.tags.work sourcegraph) ++
  (lib.optionals locals.tags.personal personal)
  )
