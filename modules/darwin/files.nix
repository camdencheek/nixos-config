_:

{
  ".config/aerospace/aerospace.toml" = {
    text = builtins.readFile ./config/aerospace.toml;
  };

  # TODO: this is sourcegraph specific
  ".bin/bazel" = {
    text = ''
      #!/bin/sh
      exec bazelisk "$@"
    '' ;
    executable = true;
  };
}
