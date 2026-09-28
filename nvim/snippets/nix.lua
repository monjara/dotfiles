  return {
    {
      prefix = 'flake',
      desc = 'Nix flake development shell',
      body = [=[{
    inputs = {
      flake-utils.url = "github:numtide/flake-utils";
      nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    };

    outputs =
      inputs:
      inputs.flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = (import (inputs.nixpkgs) { inherit system; });
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              ${1:packages}
            ];
          };
        }
      );
  }$0]=],
    },
  }
