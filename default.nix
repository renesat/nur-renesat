{ system ? builtins.currentSystem, pkgs ? import <nixpkgs> {
  inherit system;
  overlays = (import ./overlays.nix);
} }:

let
  aliases = {
    autorestic = throw "Use `pkgs.autorestic` instead";
    datalad = throw "Use `pkgs.datalad` instead";
    warpd = throw "Use `pkgs.warpd` instead";
  };
  packages = {
    activitywatch-bin = pkgs.callPackage ./pkgs/activitywatch-bin { };
  };
  supportedSystem = (name: pkg: builtins.elem system pkg.meta.platforms);
in (pkgs.lib.filterAttrs supportedSystem packages) // aliases
