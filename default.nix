{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
  projectDir = ./.;

  #src =  ./imgapp; 
  #src = pkgs.poetry2nix.cleanPythonSources { src = ./imgapp; };

}

