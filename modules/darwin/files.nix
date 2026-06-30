{ config, ... }:

let
  repoDir = "${config.home.homeDirectory}/src/camdencheek/nixos-config";
in
{
  ".config/wezterm/wezterm.lua" = {
    text = builtins.readFile ./config/wezterm.lua;
  };

  ".config/zed/settings.json" = {
    text = builtins.readFile ./config/zed/settings.json;
  };

  ".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/nvim";
  };

  ".config/zsh/fzf-key-bindings.zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/zsh/fzf-key-bindings.zsh";
  };

  ".config/git" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/git";
  };

  ".psqlrc" = {
    text = builtins.readFile ./config/psqlrc;
  };

  ".config/ghostty/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/ghostty/config";
  };

  ".config/jj" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/jj";
  };

  ".ssh/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/modules/darwin/config/ssh/config";
  };
}
