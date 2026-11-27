{ lib, python313Packages, fetchurl }:

python313Packages.buildPythonApplication {
  pname = "mnemosyne-memory";
  version = "4.0.0";
  pyproject = true;

  # PyPI's 3.15.1 sdist uses a hash-scoped URL; fetchPypi's legacy URL returns 404.
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/85/bd/c63cc3ea358afd5a7b2a24696bbb4b7d3f6172b5f370b916eedd554da3ae/mnemosyne_memory-4.0.0.tar.gz";
    name = "mnemosyne_memory-4.0.0.tar.gz";
    hash = "sha256-vuTbo8Lrc/N2TIljAV7vEGnworbx+q3xcC68Rm6PXQ0=";
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
