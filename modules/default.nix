{ inputs, ... }: {
  flake = {
    inherit (inputs) nixpkgs;
    inherit (inputs) nixpkgs-stable;
  };
}
