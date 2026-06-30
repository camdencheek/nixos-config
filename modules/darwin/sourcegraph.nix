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
      pcre
      redis
      pspg
    ];

    # Sourcegraph-specific homebrew casks
    homebrew.casks = [
      "cleanshot"
      "postgres-app"
    ];

    # Sourcegraph-specific files and configurations
    home-manager.users.${locals.username} = {

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
