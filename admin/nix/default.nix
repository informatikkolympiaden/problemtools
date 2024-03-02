{pkgs ? import <nixpkgs> {}}: 

let 
    plastex = pkgs.python3.pkgs.callPackage (import ./plastex.nix) {};

    checktestdata-src = pkgs.fetchFromGitHub {
        owner = "DOMjudge";
        repo = "checktestdata";
        rev = "38dda218dff402a13319c552f363bbf7444ac1a1";
        sha256 = "sha256-S23SKwiv9ou6JDrOiXS3+OuvR4aBJ6uzIff5BE2HTHE=";
    };
in

pkgs.python3.pkgs.buildPythonApplication {
    name = "problemtools";
    format = "setuptools";

    src = ../../.;

    patchPhase = ''
        mkdir -p support/checktestdata
        cp -r ${checktestdata-src}/* support/checktestdata
    '';

    doCheck = false;

    pipInstallFlags = [ "--use-pep517" ];
    pipBuildFlags = [ "--use-pep517" ];

    buildInputs = [
        pkgs.python3.pkgs.setuptools
    ];

    nativeBuildInputs = [
        pkgs.automake
        pkgs.autoconf
    ];

    propagatedBuildInputs = [
        pkgs.boost
        pkgs.gmpxx
        pkgs.python3.pkgs.pyyaml
        #pkgs.texlive.combined.scheme-basic
        #pkgs.ghostscript
        pkgs.html-tidy
        plastex
    ];
}
