{ inputs, ... }:
{
  flake = {
    inherit (inputs) nixpkgs;
    inherit (inputs) nixpkgs-unstable;
    inherit (inputs) nixpkgs-stable;
  };

  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "phenix-pins-dev";
        packages = with pkgs; [
          devenv
          git
          nix
        ];
        shellHook = ''
          echo "phenix-pins dev shell"
          echo "  maintenance: devenv test"
          echo "  fixes:       devenv tasks run maintenance:fix"
        '';
      };
    };
}
