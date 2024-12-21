{ inputs, ... }:
{
  config.flake.testOutput = { inherit (inputs) home-manager; };
}
