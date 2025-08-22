{
  description = "A flake for generating conventional commit messages with LLM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        default = self.packages.${system}.gen-commit;
        gen-commit = pkgs.stdenv.mkDerivation {
          name = "gen-commit";
          src = ./.;
          installPhase = ''
            mkdir -p $out/bin
            cp gen-commit.sh $out/bin/gen-commit
            chmod +x $out/bin/gen-commit
          '';
          meta = {
            description = "Generate conventional commit messages using LLM";
            homepage = "https://github.com/rodeyseijkens/nixos-config";
            license = pkgs.lib.licenses.mit;
            platforms = pkgs.lib.platforms.all;
          };
        };
      };

      apps = {
        default = {
          type = "app";
          program = "${self.packages.${system}.gen-commit}/bin/gen-commit";
        };
        gen-commit = {
          type = "app";
          program = "${self.packages.${system}.gen-commit}/bin/gen-commit";
        };
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          bash
          git
        ];
      };
    });
}
