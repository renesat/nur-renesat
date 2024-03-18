{
  lib,
  fetchFromGitHub,
  rustPlatform,
  buildPythonPackage,
  callPackage,
  protobuf,
  pytestCheckHook,
}:
buildPythonPackage rec {
  pname = "vl-convert-python";
  version = "1.2.4";

  src = fetchFromGitHub {
    owner = "vega";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-emydeonsIFlTc76kTbxNQ7aEmm4FZVYOre+bBhW6fX8=";
  };

  buildAndTestSubdir = "vl-convert-python/";

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    postPatch = ''
      ln -s ../Cargo.lock Cargo.lock
    '';
    sourceRoot = "${src.name}/vl-convert-python";
    name = "${pname}-${version}";
    hash = "sha256-qyKOqpbe4UP/JADj/k5s1u+wUfQiRTNe0xO9EebdqYw=";
  };

  format = "pyproject";

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook];
  buildInputs = [protobuf];

  nativeCheckInputs = [pytestCheckHook];
  disabledTestPaths = [
    # Tests requires pypdfium2
    "vl-convert-python/tests/test_specs.py"
  ];
  pythonImportsCheck = ["vl_convert"];

  RUSTY_V8_ARCHIVE = callPackage ./librusty_v8.nix {};
}
