{ lib, ... }:
let
  maintenanceModules = builtins.filter (
    path: builtins.baseNameOf path == "maintenance.nix"
  ) (lib.filesystem.listFilesRecursive ./.);
in
{
  imports = maintenanceModules;

  # Tasks attach themselves to this lifecycle event. Keeping the root file
  # declarative lets each repository area own its checks and dependencies.
  enterTest = "";
}
