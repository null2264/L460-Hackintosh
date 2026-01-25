{
  description = "null2264's ThinkPad L460 OpenCore Hackintosh";

  outputs = { self, nixpkgs, utils, oceanix, configFile, ... }:
  {
    opencoreConfigurations = (utils.lib.eachSystem ["x86_64-linux" "x86_64-darwin"] (system: {
      l460 = oceanix.lib.OpenCoreConfig {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ oceanix.overlays.default ];
        };

        extraSpecialArgs = { params = (import configFile); };

        modules = [
          ./Nix/modules
        ];
      };
    }));
  };

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";

    utils.url = "github:numtide/flake-utils";

    oceanix = {
      url = "github:null2264/oceanix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };

    configFile = { url = "path:./Nix/include/sample.nix"; flake = false; };
  };
}
