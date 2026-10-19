{ lib, python313Packages, fetchPypi }:

python313Packages.buildPythonApplication {
  pname = "mnemosyne-memory";
  version = "3.15.1";
  pyproject = true;

  src = fetchPypi {
    pname = "mnemosyne-memory";
    version = "3.15.1";
    hash = "sha256-lspUMxc0pUSkhSUrNdiiO5OJ1NMC/S853EYSanXtXKM=";
  };

  nativeBuildInputs = with python313Packages; [
    setuptools
    wheel
  ];

  dependencies = with python313Packages; [
    pyyaml
    fastembed
    onnxruntime
    sqlite-vec
  ];

  meta = {
    description = "Local-first SQLite-backed AI memory CLI";
    homepage = "https://github.com/mnemosyne-oss/mnemosyne";
    license = lib.licenses.mit;
    mainProgram = "mnemosyne";
    platforms = lib.platforms.linux;
  };
}
