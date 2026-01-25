{ config, lib, pkgs, params, ... }:

let
  cfg = config.oceanix;
in {
  imports = [
    ./config/ACPI.nix
    ./config/Booter.nix
    ./config/DeviceProperties.nix
    ./config/Kernel.nix
    ./config/Misc.nix
    ./config/NVRAM.nix
    ./config/PlatformInfo.nix
    ./config/UEFI.nix
  ];

  kexts.applealc = {
    enable = true;
    type = "alc";
  };

  kexts.cpufriend = {
    enable = true;
    dataProvider = ../../Include/PlugIns/CPUFriendDataProvider.kext;
  };

  kexts.intel-bluetooth-firmware = {
    enable = true;
    includeBlueToolFixup = true;
  };

  kexts.intel-mausi = {
    enable = true;
    type = "temperate";
  };

  kexts.itlwm = {
    enable = true;
    # This allow itlwm to auto connect to a wifi without HeliPort's help
    wifiProfiles = (params.wifiProfiles or [
      {
        ssid = "dingus";
        password = "dingus12345678";
      }
    ]);
  };

  kexts.usbtoolbox = {
    enable = true;
    mapping = ../../Include/PlugIns/UTBMap.kext;
  };

  kexts.virtualsmc = {
    enable = true;
    includedPlugins = [
      "SMCBatteryManager"
      "SMCProcessor"
    ];
  };

  kexts.yogasmc = {
    enable = true;
    type = "lilu";
  };

  oceanix.opencore = {
    validate = true;
    package =
      let
        driversToKeep = [
          "AudioDxe.efi"
          "OpenCanopy.efi"
          "OpenRuntime.efi"
          "Ps2KeyboardDxe.efi"
          "ResetNvramEntry.efi"
        ];
        toolsToKeep = [
          "OpenControl.efi"
          "OpenShell.efi"
        ];
      in pkgs.oc.opencore.overrideAttrs (old: {
        installPhase = ''
          find ./${cfg.opencore.arch}/EFI/OC/Drivers -type f -iname "*.efi" \! \( -iname ${builtins.concatStringsSep " -o -iname " driversToKeep} \) -exec rm -r \{\} +
          find ./${cfg.opencore.arch}/EFI/OC/Tools -type f -iname "*.efi" \! \( -iname ${builtins.concatStringsSep " -o -iname " toolsToKeep} \) -exec rm -r \{\} +

          ${old.installPhase or ""}
        '';
      });
    # We already filter out the unnecessary drivers and tools, so just auto enable them all
    autoEnableDrivers = true;
    autoEnableTools = true;
    # All the included ACPI patches included in 'Patches/' dir are used so let's just auto enable them
    autoEnableACPI = true;
    resources = {
      ACPIFolders = [ ../../Patches ];
      KextsFolders = [ ../../Kexts ];
      DriversFolders = [ ../../Drivers ];
      ResourcesFolders = [ ../../Include/Resources ];
      packages = [
        pkgs.oc.lilu
        #pkgs.oc.airportitlwm.latest-ventura
        pkgs.oc.applemcereporterdisabler
        pkgs.oc.brightnesskeys
        pkgs.oc.cputscsync
        pkgs.oc.ctlnaahciport
        pkgs.oc.debugenhancer
        pkgs.oc.ecenabler
        pkgs.oc.hibernationfixup
        pkgs.oc.ibridged
        pkgs.oc.restrictevents
        pkgs.oc.voltageshift
        pkgs.oc.voodoops2
        pkgs.oc.voodoormi
        pkgs.oc.whatevergreen
      ];
    };
  };
}
