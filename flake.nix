{
  description = "gilbertoacp nixos configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };  

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      gilberto = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "gilberto";
        homeDirectory = "/home/gilberto";
        configuration = {
          imports = [
            ./home.nix
          ];
        };
      };
    };

    nixosConfigurations = {
      gilberto = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix 
        ];
      };
    };
  };
}
