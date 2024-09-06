home $host:
  home-manager switch --flake .#$host

nixos $host:
  sudo nixos-rebuild switch --flake .#$host
