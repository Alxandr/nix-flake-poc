{ flake-parts, nixpkgs }:
let
  lib = nixpkgs.lib;
  flake-parts-lib = flake-parts.lib;

  mkStage =
    path:
    { flake, inputs }:
    (lib.fixedPoints.fix (
      self:
      let
        args = inputs // {
          inherit self;
        };
        outputs =
          flake-parts-lib.mkFlake
            {
              inputs = args;
              moduleLocation = path;
            }
            {
              imports = [ path ];
            };
      in
      outputs
      // {
        _type = "flake";
        inherit inputs outputs;
      }
    ));
in
{
  inherit mkStage;
}
