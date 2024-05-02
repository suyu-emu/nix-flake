{
  description = "A flake of an experimental Nintendo Switch emulator written in C++";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # todo: get a mac
    # todo: wait for suyu to get good on MacOS
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, systems, ... }: 
  let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in
  {
    packages = eachSystem (system: 
    let
      pkgs = import nixpkgs {
        system = "${system}";
        config = {allowUnfree = true;}; # cuda
      };

      # Qt6 packages have been moved to kdePackages so we grab them all here so they are not
      # confused with their Qt5 counterparts
      suyu-deps = pkgs.kdePackages // {inherit (self.packages.${system}) nx_tzdb compat-list;};
    in {
      default = self.packages.${system}.suyu;
      nx_tzdb = pkgs.callPackage ./suyu/nx_tzdb.nix {};
      compat-list = pkgs.callPackage ./suyu/compat-list.nix {};
      suyu = pkgs.callPackage ./suyu/suyu.nix suyu-deps;
    }
    );
  };
}
