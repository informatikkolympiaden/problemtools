{pkgs ? import <nixpkgs> {}}: 

let 
    plastex = pkgs.python3.pkgs.callPackage (import ./plastex.nix) {};
in

pkgs.python3.pkgs.buildPythonApplication {
    name = "problemtools";
    format = "setuptools";

    src = pkgs.fetchFromGitHub {
        owner = "informatikkolympiaden";
        repo = "problemtools";
        rev = "5ebda4b41eb00a8b1699fadd96187d360d1c4bbf";
        sha256 = "sha256-cVnr8aTIvundFLd6mV0OZh4TeJIXTwodG8vHRLLRwcQ=";
        fetchSubmodules = true;
    };

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
