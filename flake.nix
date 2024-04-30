{
  description = "A flake of an experimental Nintendo Switch emulator written in C++";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = 
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {allowUnfree = true;};
      };
      suyu-deps = pkgs.kdePackages // {inherit (self.packages.x86_64-linux) nx_tzdb compat-list;};
    in {
      default = self.packages.x86_64-linux.suyu;
      nx_tzdb = pkgs.callPackage ./suyu/nx_tzdb.nix {};
      compat-list = pkgs.callPackage ./suyu/compat-list.nix {};
      suyu = pkgs.callPackage ./suyu/suyu.nix suyu-deps;
    };
  };
}
