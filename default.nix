{
  system ? builtins.currentSystem,
  pkgs ?
    import <nixpkgs> {
      inherit system;
      overlays = import ./overlays.nix;
    },
}: let
  aliases = {
    autorestic = throw "Use `pkgs.autorestic` instead";
    datalad = throw "Use `pkgs.datalad` instead";
    warpd = throw "Use `pkgs.warpd` instead";
  };
  packages = rec {
    "1fps" = pkgs.callPackage ./pkgs/1fps {};
    activitywatch-bin = pkgs.callPackage ./pkgs/activitywatch-bin {};
    daqp = pkgs.callPackage ./pkgs/daqp {};
    daqp-python = pkgs.callPackage ./pkgs/daqp/python.nix {};
    drawille = pkgs.callPackage ./pkgs/drawille {};
    drawilleplot = pkgs.callPackage ./pkgs/drawilleplot {};
    hledger-utils = pkgs.callPackage ./pkgs/hledger-utils {};
    imap-backup = pkgs.callPackage ./pkgs/imap-backup {};
    math-preview = pkgs.callPackage ./pkgs/math-preview {};
    normcap = pkgs.callPackage ./pkgs/normcap {};
    puffin = pkgs.callPackage ./pkgs/puffin {};
    qpsolvers = pkgs.callPackage ./pkgs/qpsolvers {daqp = daqp-python;};
    questdb = pkgs.callPackage ./pkgs/questdb {};
    taskwarrior3 = pkgs.callPackage ./pkgs/taskwarrior3 {};

    aiolinkding = pkgs.python3Packages.callPackage ./pkgs/aiolinkding {};
    arro3-core = pkgs.python3Packages.callPackage ./pkgs/arro3-core {};
    linkding-cli = pkgs.python3Packages.callPackage ./pkgs/linkding-cli {inherit aiolinkding;};
    vegafusion = pkgs.python3Packages.callPackage ./pkgs/vegafusion {inherit arro3-core;};
    vl-convert-python = pkgs.python3Packages.callPackage ./pkgs/vl-convert-python {};
  };
  supportedSystem = _: pkg: builtins.elem system pkg.meta.platforms;
in
  (pkgs.lib.filterAttrs supportedSystem packages) // aliases
