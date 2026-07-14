{ inputs, ... }:
{
  flake = {
    inherit (inputs) nixpkgs;
    inherit (inputs) nixpkgs-unstable;
    inherit (inputs) nixpkgs-stable;
  };

  perSystem =
    { pkgs, ... }:
    let
      # phenix-tend consumes phenix-pins, so pins cannot add Tend as a flake
      # input without creating a cycle. Bootstrap the verified CLI revision as
      # an out-of-graph application instead.
      tendRevision = "440e41d22d22fb124d221146d08f84f75f751697";
      tendBootstrap = pkgs.writeShellApplication {
        name = "tend";
        runtimeInputs = [ pkgs.nix ];
        text = ''
          exec nix run --accept-flake-config \
            "github:matthis-k/phenix-tend/${tendRevision}#tend" -- "$@"
        '';
      };
    in
    {
      devShells.default = pkgs.mkShell {
        name = "phenix-pins-dev";
        packages = with pkgs; [
          nix
          nixfmt
          statix
          deadnix
          tendBootstrap
        ];
        shellHook = ''
          repo-hook() {
            tend check --profile git-hook --context local "$@"
          }
          repo-pushgate() {
            tend check --profile pre-push --context local "$@"
          }
          repo-check() {
            tend check --profile manual --context local "$@"
          }
          repo-fix() {
            tend check --profile fix --context local "$@"
          }
          export -f repo-hook repo-pushgate repo-check repo-fix 2>/dev/null || true

          echo "phenix-pins dev shell"
          echo "  tools: nix nixfmt statix deadnix tend"
          echo "  Tend is bootstrapped from ${tendRevision} to avoid a pins -> Tend cycle"
          echo "  repo-hook      -> tend check --profile git-hook --context local"
          echo "  repo-pushgate  -> tend check --profile pre-push --context local"
          echo "  repo-check     -> tend check --profile manual --context local"
          echo "  repo-fix       -> tend check --profile fix --context local"
        '';
      };
    };
}
