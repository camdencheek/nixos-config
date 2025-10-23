{ config, lib, ... }:

{
  ".config/wezterm/wezterm.lua" = {
    text = builtins.readFile ./config/wezterm.lua;
  };

  ".config/zed/settings.json" = {
    text = builtins.readFile ./config/zed/settings.json;
  };

  ".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/darwin/config/nvim";
  };

  ".config/atuin/config.toml" = {
    source = ./config/atuin.toml;
    recursive = true;
  };

  ".config/zsh/fzf-key-bindings.zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/darwin/config/zsh/fzf-key-bindings.zsh";
  };


  ".config/git" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/darwin/config/git";
  };

  ".psqlrc" = {
  text = builtins.readFile ./config/psqlrc;
  };

  ".config/ghostty/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/darwin/config/ghostty/config";
  };
 
  # Bazel wrapper moved to sourcegraph.nix
}
