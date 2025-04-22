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
    "macfuse"
    "visual-studio-code"

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
    "cleanshot"
    "superwhisper"

    # Browsers
    "google-chrome"
    "firefox@developer-edition"
    "firefox"

    # Other
    "gimp"
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
