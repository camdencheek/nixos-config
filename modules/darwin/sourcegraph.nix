{
  config,
  lib,
  pkgs,
  locals,
  ...
}:

let
  cfg = config.my.sourcegraph;
in
{
  options.my.sourcegraph = {
    enable = lib.mkEnableOption "Sourcegraph-specific configuration";
  };

  config = lib.mkIf cfg.enable {
    # Sourcegraph-specific packages
    environment.systemPackages = with pkgs; [
      # Development tools
      pcre
      redis
      pspg
    ];

    # Sourcegraph-specific homebrew casks
    homebrew.casks = [
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
