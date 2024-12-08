{ pkgs, config, ... }:

# let
#  githubPublicKey = "ssh-ed25519 AAAA...";
# in
{

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  ".config/wezterm/wezterm.lua" = {
    text = builtins.readFile ./config/wezterm.lua;
  };

  # TODO: this is MacOS-only. Move it to the darwin module.
  ".config/aerospace/aerospace.toml" = {
    text = builtins.readFile ./config/aerospace.toml;
  };

  ".config/zed/settings.json" = {
    text = builtins.readFile ./config/zed.json;
  };

  ".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
