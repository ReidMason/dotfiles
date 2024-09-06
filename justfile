home $host:
  home-manager switch --flake .#$host

nixos $host:
  sudo nixos-rebuild switch --flake .#$host

darwin $host:
    nix run nix-darwin -- switch --flake .#$host

