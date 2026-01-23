{ lib, pkgs, params, ... }:

with lib.oc.plist;

let
  # NOTE: Use GenSMBIOS to get values for MLB, Serial Number and UUID
  findValue = var: if builtins.pathExists ../../include/${var} then (builtins.readFile ../../include/${var}) else "";
  mlb = findValue "mlb";
  serialNumber = findValue "serialnumber";
  systemUUID = findValue "uuid";
in {
  oceanix.opencore.settings.PlatformInfo = {
    Generic = {
      MLB = params.MLB;
      SystemSerialNumber = params.SystemSerialNumber;
      SystemUUID = params.SystemUUID;
      ROM = mkData "VOGtP43i";  # NOTE: Recommended to be changed to your own MAC Address
      SystemProductName = "MacBookPro14,1";
    };
  };
}
