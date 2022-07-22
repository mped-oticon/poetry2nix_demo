{ pkgs ? import <nixpkgs> {}, allthepoetrystuff ? import ./default.nix {} }:

pkgs.mkShell {

  buildInputs = [
    pkgs.python3
    pkgs.poetry
    allthepoetrystuff
  ];

}

