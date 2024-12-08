{ ... }:

{
  ".config/aerospace/aerospace.toml" = {
    text = builtins.readFile ./config/aerospace.toml;
  };
}
