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

  ".config/aerospace/aerospace.toml" = {
    text = builtins.readFile ./config/aerospace.toml;
  };
}
