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
  
  # Sourcegraph-specific bazel wrapper
  ".bin/bazel" = {
    text = ''
      #!/bin/sh
      exec bazelisk "$@"
    '' ;
    executable = true;
  };
}
