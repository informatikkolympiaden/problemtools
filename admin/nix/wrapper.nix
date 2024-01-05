{pkgs ? import <nixpkgs> {}}: 

let
    gcc-wrapper = pkgs.writeShellScriptBin "gcc" ''
        export NIX_LDFLAGS="$NIX_LDFLAGS -L${pkgs.glibc.static}/lib"
        export NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}=1
        ${pkgs.gcc}/bin/gcc "$@"
    '';

    gpp-wrapper = pkgs.writeShellScriptBin "g++" ''
        export NIX_LDFLAGS="$NIX_LDFLAGS -L${pkgs.glibc.static}/lib"
        export NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}=1
        ${pkgs.gcc}/bin/g++ "$@"
    '';

    env = pkgs.buildEnv {
        name = "verifyproblem-env";
        paths = with pkgs; [
            gcc-wrapper
            gpp-wrapper
            rustc
            python3
            jdk17_headless
        ];
    };
in

pkgs.writeShellScript "verifyproblem-env" ''
    export PATH="${env}/bin:$PATH"
    "$@"
''
