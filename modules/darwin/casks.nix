{lib, config, ...}:

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
in {
  imports = [../shared/locals.nix];
  config = lib.unique (
  default ++
  (lib.optionals config.locals.tags.work sourcegraph));
}
