{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, jinja2
, unidecode
, pillow
, typing-extensions
}:

buildPythonPackage rec {
    pname = "plasTeX";
    version = "3.0";

    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-YO/LrUdQS+0Ch34JkN3HgsDM68c6jbnPuo/CULwAIlI=";
    };

    doCheck = false;

    propagatedBuildInputs = [
        jinja2
        unidecode
        pillow
        typing-extensions
    ];
}
