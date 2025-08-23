home $host:
  git add .
  home-manager switch --flake .#$host

nixos $host:
  git add .
  sudo nixos-rebuild switch --flake .#$host

darwin $host:
  git add .
  nix run nix-darwin -- switch --flake .#$host

