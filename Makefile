build:
	nixos-rebuild build --flake ".#"

switch:
	sudo nixos-rebuild switch --flake ".#"  

switch-users:
	nix build .#homeManagerConfigurations.gilberto.activationPackage
	./result/activate

all: switch switch-users