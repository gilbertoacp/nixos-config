build:
	nixos-rebuild build --flake ".#"

apply:
	nixos-rebuild switch --flake ".#"  

update:
	nix flake update 

apply-users:
	nix build .#homeManagerConfigurations.gilberto.activationPackage
	./result/activate