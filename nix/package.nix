{ lib, python313Packages, fetchurl }:

python313Packages.buildPythonApplication {
  pname = "mnemosyne-memory";
  version = "3.15.1";
  pyproject = true;

  # PyPI's 3.15.1 sdist uses a hash-scoped URL; fetchPypi's legacy URL returns 404.
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/42/58/968d0f74505fdb2db9a7508192720c5faa9a351313f04acd0ba09b553a9f/mnemosyne_memory-3.15.1.tar.gz";
    name = "mnemosyne_memory-3.15.1.tar.gz";
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
