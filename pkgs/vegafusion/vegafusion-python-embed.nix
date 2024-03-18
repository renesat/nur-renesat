{
  lib,
  fetchFromGitHub,
  rustPlatform,
  buildPythonPackage,
  protobuf,
}:
buildPythonPackage rec {
  pname = "vegafusion-python-embed";
  version = "1.6.5";

  src = fetchFromGitHub {
    owner = "hex-inc";
    repo = "vegafusion";
    rev = "v${version}";
    hash = "sha256-EoNbcMOTqyC/nFttQhWQ2iNGxSwZWkbnCL4W3O+D0As=";
  };

  buildAndTestSubdir = "vegafusion-python-embed/";

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    postPatch = ''
      ln -s ../Cargo.lock Cargo.lock
    '';
    sourceRoot = "${src.name}/vegafusion-python-embed";
    name = "${pname}-${version}";
    hash = "sha256-fNe5XW8LinUFhJYJTFXjCDGZkK+xDTAS4mE3gvnGKRo=";
  };

  format = "pyproject";

  nativeBuildInputs = with rustPlatform; [cargoSetupHook maturinBuildHook];
  buildInputs = [protobuf];

  pythonImportsCheck = ["vegafusion_embed"];
}
