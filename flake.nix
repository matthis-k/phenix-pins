{
  description = "Phenix shared nixpkgs and tooling pins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = inputs: {
    nixpkgs = inputs.nixpkgs;
    nixpkgs-stable = inputs.nixpkgs-stable;
  };
}
