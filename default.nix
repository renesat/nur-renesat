{
  system ? builtins.currentSystem,
  pkgs ?
    import <nixpkgs> {
      inherit system;
      overlays = import ./overlays.nix;
    },
}: let
  inherit (builtins) warn;
  aliases = {
    autorestic = warn "Please use `autorestic` from nixpkgs: `pkgs.autorestic`" pkgs.autorestic;
    datalad = warn "Please use `datalad` from nixpkgs: `pkgs.datalad`" pkgs.datalad;
    warpd = warn "Please use `warpd` from nixpkgs: `pkgs.warpd`" pkgs.warpd;
    taskwarrior3 = warn "Please use `taskwarrior3` from nixpkgs: `pkgs.taskwarrior3`" pkgs.taskwarrior3;
    "1fps" = warn "Please use `1fps` from nixpkgs: `pkgs._1fps`" pkgs._1fps;
    puffin = warn "Please use `puffin` from nixpkgs: `pkgs.puffin`" pkgs.puffin;
    math-preview = warn "Please use `math-preview` from nixpkgs: `pkgs.math-preview`" pkgs.math-preview;
    activitywatch-bin = warn "Please use `activitywatch-bin` from nixpkgs: `pkgs.activitywatch`" pkgs.activitywatch;
    daqp-python = warn "Please use `daqp-python` from nixpkgs: `pkgs.python3Packages.daqp`" pkgs.python3Packages.daqp;
    drawille = warn "Please use `drawille` from nixpkgs: `pkgs.python3Packages.drawille`" pkgs.python3Packages.drawille;
    drawilleplot = warn "Please use `drawilleplot` from nixpkgs: `pkgs.python3Packages.drawilleplot`" pkgs.python3Packages.drawilleplot;
    hledger-utils = warn "Please use `hledger-utils` from nixpkgs: `pkgs.hledger-utils`" pkgs.hledger-utils;
    normcap = warn "Please use `normcap` from nixpkgs: `pkgs.normcap`" pkgs.normcap;
    qpsolvers = warn "Please use `qpsolvers` from nixpkgs: `pkgs.python3Packages.qpsolvers`" pkgs.python3Packages.qpsolvers;
    questdb = warn "Please use `questdb` from nixpkgs: `pkgs.questdb`" pkgs.questdb;
  };
  packages = rec {
    toutui = pkgs.callPackage ./pkgs/toutui {};
    daqp = pkgs.callPackage ./pkgs/daqp {};
    imap-backup = pkgs.callPackage ./pkgs/imap-backup {};
    vl-convert = pkgs.callPackage ./pkgs/vl-convert {};
    dedoc = pkgs.callPackage ./pkgs/dedoc {};
    age-edit = pkgs.callPackage ./pkgs/age-edit {};

    flatlatex = pkgs.python3Packages.callPackage ./pkgs/flatlatex {};
    sixelcrop = pkgs.python3Packages.callPackage ./pkgs/sixelcrop {};
    timg = pkgs.python3Packages.callPackage ./pkgs/timg {};
    euporie = pkgs.python3Packages.callPackage ./pkgs/euporie {inherit flatlatex sixelcrop timg;};
    aiolinkding = pkgs.python3Packages.callPackage ./pkgs/aiolinkding {};
    arro3-core = pkgs.python3Packages.callPackage ./pkgs/arro3-core {};
    linkding-cli = pkgs.python3Packages.callPackage ./pkgs/linkding-cli {inherit aiolinkding;};
    vegafusion = pkgs.python3Packages.callPackage ./pkgs/vegafusion {inherit arro3-core;};
    vl-convert-python = pkgs.python3Packages.callPackage ./pkgs/vl-convert-python {
      inherit vl-convert;
    };
  };
  supportedSystem = _: pkg: builtins.elem system pkg.meta.platforms;
in
  (pkgs.lib.filterAttrs supportedSystem packages) // aliases
