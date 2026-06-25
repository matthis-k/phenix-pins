{ inputs, ... }: {
  flake = {
    nixpkgs = inputs.nixpkgs;
    nixpkgs-stable = inputs.nixpkgs-stable;
  };
}
