{ lib, ... }:

with lib; {
  options = {
    locals  = {
      username = mkOption {
        type = types.str;
        default = "ccheek";
      };
      tags = {
        personal = mkOption {
          type = types.bool;
        };
        work = mkOption {
          type = types.bool;
        };
      };
    };
  };
}
