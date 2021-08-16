build:
	nixos-rebuild build --flake ".#"

apply:
	nixos-rebuild switch --flake ".#"  

