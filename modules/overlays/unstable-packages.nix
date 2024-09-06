{ nixpkgs-unstable, ... }: {
  unstable-packages = final: _prev: {
    unstable = import nixpkgs-unstable
    {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
