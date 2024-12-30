_:

{
  # TODO: this is sourcegraph specific
  ".bin/bazel" = {
    text = ''
      #!/bin/sh
      exec bazelisk "$@"
    '';
    executable = true;
  };
}
