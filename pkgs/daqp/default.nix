{
  lib,
  stdenv,
  python3,
  fetchFromGitHub,
  cmake
}:
stdenv.mkDerivation rec {
  pname = "daqp";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "darnstrom";
    repo = "daqp";
    rev = "v${version}";
    hash = "sha256-e2T5+DNMJq4eBhj8F7kKgfGIozFRTuDif3oQ08lIStA=";
  };

  nativeBuildInputs = [cmake];

  meta = with lib; {
#    description = "Quadratic programming solvers in Python with a unified API";
#    homepage = "https://github.com/qpsolvers/qpsolvers";
#    license = licenses.lgpl3;
    maintainers = with maintainers; [renesat];
    platforms = [ "x86_64-linux" ];
  };
}
