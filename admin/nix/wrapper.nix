{pkgs ? import <nixpkgs> {}}: 

let
    env = pkgs.buildEnv {
        name = "verifyproblem-env";
        paths = with pkgs; [
            gcc
            rustc
            python3
            jdk17_headless
        ];
    };
in

pkgs.writeShellScript "verifyproblem-env" ''
    export PATH="$PATH:${env}/bin"
    export NIX_LDFLAGS="$NIX_LDFLAGS -L${pkgs.glibc.static}/lib"
    export NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}=1
    "$@"
''
