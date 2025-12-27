{
  description = "Development environment for probitas-test/claude-plugins";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    probitas-flake.url = "github:probitas-test/probitas";
    probitas-flake.inputs.nixpkgs.follows = "nixpkgs";
    probitas-flake.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, probitas-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ probitas-flake.overlays.default ];
        };
      in {
        packages.default = pkgs.probitas;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            deno
            pagefind
            probitas
          ];

          shellHook = ''
            export DENO_NO_UPDATE_CHECK=1
          '';
        };
      });
}
