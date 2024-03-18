{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonAtLeast,

  # Deps
  altair,
  pyarrow,
  pandas,
  psutil,
  protobuf,
  packaging, # python >= 3.12
  vl-convert-python, # embed
  vegafusion-python-embed, # embed

  # Test
  vega_datasets,
  polars,
  duckdb,
  scikit-image,
}:
buildPythonPackage rec {
  pname = "vegafusion";
  version = "1.6.5";

  src = fetchFromGitHub {
    owner = "hex-inc";
    repo = "vegafusion";
    rev = "v${version}";
    hash = "sha256-EoNbcMOTqyC/nFttQhWQ2iNGxSwZWkbnCL4W3O+D0As=";
  };

  patches = [
    ./distutils_fix.patch
  ];

  sourceRoot = "${src.name}/python/vegafusion";

  doCheck = false;
  # nativeBuildInputs = [pytestCheckHook];

  propagatedBuildInputs =
    [
      altair
      pyarrow
      pandas
      psutil
      protobuf
    ]
    ++ lib.lists.optional (pythonAtLeast "3.12") packaging;

  # checkInputs = [
  #   vega_datasets
  #   polars
  #   duckdb
  #   vl-convert-python
  #   scikit-image
  #   vegafusion-python-embed
  # ];

  optional-dependencies = {
    embed = [
      vegafusion-python-embed
      vl-convert-python
    ];
  };

  meta = with lib; {
    description = " Pixel graphics in terminal with unicode braille characters";
    homepage = "https://github.com/asciimoo/drawille";
    license = licenses.gpl3;
    maintainers = with maintainers; [renesat];
  };
}
