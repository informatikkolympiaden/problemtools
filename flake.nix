{
    inputs.nixpkgs.url = "nixpkgs/23.11";

    outputs = {self, nixpkgs, ...}@inputs: 
    let
        allSystems = [
            "x86_64-linux"
        ];
        forAllSystems = fn: nixpkgs.lib.genAttrs allSystems 
            (system: fn { inherit system; pkgs = import nixpkgs {inherit system; }; });
    in {
        packages = forAllSystems ({pkgs, system}: 
        let
            problemtools-unwrapped = self.packages.${system}.problemtools-unwrapped;
            verifyproblem-unwrapped = "${problemtools-unwrapped}/bin/verifyproblem";
            verifyproblem-env = import ./admin/nix/wrapper.nix { inherit pkgs; };
        in {
            problemtools-unwrapped = import ./admin/nix/default.nix { inherit pkgs; };
            verifyproblem = pkgs.writeShellScriptBin "verifyproblem" ''
                ${verifyproblem-env} ${verifyproblem-unwrapped} "$@"
            '';
        });
    };
}
