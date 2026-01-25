{ lib, pkgs, ... }:

with lib.oc.plist;
{
  oceanix.opencore.settings.Booter = {
    MmioWhitelist = [];
    Patch = [
      {
        Arch = "x86_64";
        Comment = "Skip Board ID check";
        Count = 0;
        Enabled = true;
        Find = mkData "AFAAbABhAHQAZgBvAHIAbQBTAHUAcABwAG8AcgB0AC4AcABsAGkAcwB0";
        Identifier = "Apple";
        Limit = 0;
        Mask = mkData "";
        Replace = mkData "AC4ALgAuAC4ALgAuAC4ALgAuAC4ALgAuAC4ALgAuAC4ALgAuAC4ALgAu";
        ReplaceMask = mkData "";
        Skip = 0;
      }
    ];

    Quirks = {
      FixupAppleEfiImages = false;
    };
  };
}
