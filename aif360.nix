{ pkgs ? import <nixpkgs> {} }:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "aif360";
  version = "0.6.1";

  src = pkgs.fetchPypi {
    pname = "aif360";
    version = "0.6.1";
    sha256 = "1wkpzga5080kd80gbh1vb3897093h185xvif4kx0hpkqpq5zqnk3";
  };

  meta = with pkgs.lib; {
    description = "AI Fairness 360 toolkit";
    homepage = "https://pypi.org/project/aif360/#description";
  };
}
