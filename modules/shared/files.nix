{ ... }:

{
  ".config/wezterm/wezterm.lua" = {
    text = builtins.readFile ./config/wezterm.lua;
  };

  ".config/zed/settings.json" = {
    text = builtins.readFile ./config/zed.json;
  };

  ".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  ".config/zsh" = {
    source = ./config/zsh;
    recursive = true;
  };

  ".psqlrc" = {
    text = builtins.readFile ./config/psqlrc;
  };
}
