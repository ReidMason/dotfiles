# Dotfiles

A collection of all my configs.
Most of these are using the nix package manager.

## Usage

Most of the configs are managed by home-manager so start by setting up the system packages.

```bash
sudo nixos-rebuild switch --flake PATH_TO_FLAKE
```

Then you can set up the user packages with home-manager.

```bash
home-manager switch --flake PATH_TO_FLAKE
```

## Editing

Each module can be enabled or disabled by setting the `enable` option to true or false in the `home.nix` file.

```nix
wezterm.enable = false;
```

### Useful nix utils

- [Home manager options](https://nix-community.github.io/home-manager/options.xhtml) - A list of all the options available in home manager for programs
- [Nixos search](https://search.nixos.org/packages) - A search engine for nix packages
- [MyNixos](https://search.nixos.org/packages) - A search engine that displays lots of useful options for nix packages
