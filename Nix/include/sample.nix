# REF: https://github.com/ggPeti/param-pkg/issues/1
{
  # NOTE: Copy this file to the same dir with the name "config.nix"
  MLB = "M0000000000000001";
  SystemSerialNumber = "W00000000001";
  SystemUUID = "00000000-0000-0000-0000-000000000000";

  # This allow itlwm to auto connect to a wifi without HeliPort's help
  wifiProfiles = [
    {
      ssid = "dingus";
      password = "dingus12345678";
    }
  ];
}
