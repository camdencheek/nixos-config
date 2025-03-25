{
  config,
  lib,
  pkgs,
  locals,
  ...
}:

with lib;

let
  cfg = config.my.sourcegraph;
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
      cloud-sql-proxy
    ]
  );
in
{
  options.my.sourcegraph = {
    enable = mkEnableOption "Enable Sourcegraph-specific configurations";
  };

  config = mkIf cfg.enable {
    # Sourcegraph-specific packages
    environment.systemPackages = with pkgs; [
      # Development tools
      gdk
      findutils
      pcre
      bazelisk
      bazel-watcher
      postgresql
      redis
      caddy
      concurrently
      pspg
      buf
      biome
      buildifier
      k9s
      kubectl
      kubernetes-helm
      terraform
      bindfs
      autoconf
      sox
    ];

    # Sourcegraph-specific homebrew casks
    homebrew.casks = [
      "linear-linear"
      "cleanshot"
      "figma"
      "notion"
      "postgres-unofficial"
      "perforce"
      "dbeaver-community"
    ];

    # Sourcegraph-specific files and configurations
    home-manager.users.${locals.username} = {
      home.file = {
        # Bazel wrapper
        ".bin/bazel" = {
          text = ''
            #!/bin/sh
            exec bazelisk "$@"
          '';
          executable = true;
        };

        # Git config for work
        ".config/git/config_work" = {
          text = ''
            [user]
            	email = camden@sourcegraph.com
          '';
        };
      };

      # Add git configuration for Sourcegraph repositories
      programs.git = {
        includes = [
          {
            condition = "gitdir:~/src/sourcegraph";
            path = "~/.config/git/config_work";
          }
        ];
      };
    };
  };
}
