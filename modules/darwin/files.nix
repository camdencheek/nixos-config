{ ... }:

{
  ".config/wezterm/wezterm.lua" = {
    text = builtins.readFile ./config/wezterm.lua;
  };

  ".config/zed/settings.json" = {
    text = builtins.readFile ./config/zed/settings.json;
  };

  ".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  ".config/atuin/config.toml" = {
    source = ./config/atuin.toml;
    recursive = true;
  };

  ".config/zsh" = {
    source = ./config/zsh;
    recursive = true;
  };

  ".config/git" = {
    source = ./config/git;
    recursive = true;
  };

  ".psqlrc" = {
    text = builtins.readFile ./config/psqlrc;
  };

  # Bazel wrapper moved to sourcegraph.nix
}
