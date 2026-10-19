# nixpkg-mnemosyne

Nix package for the stable **mnemosyne-memory 3.15.1** CLI. It includes the local embedding stack (FastEmbed, ONNX Runtime, and sqlite-vec) used by the Pi Mnemosyne extension. Model weights are not bundled; FastEmbed downloads its selected model on first use.

The package omits Mnemosyne's optional MCP and local-LLM extras: Pi calls the CLI directly, and consolidation can use the package's no-LLM fallback.

## Build and verify

    nix flake check
    nix build .#mnemosyne-memory

The check runs only mnemosyne --help; it does not load or download a model.

## Use

    nix run github:RogerNavelsaker/nixpkg-mnemosyne

The CLI stores data under Mnemosyne's default per-user data directory unless MNEMOSYNE_DATA_DIR is set. Set MNEMOSYNE_EMBEDDING_MODEL to choose a local FastEmbed model. The agent profiles pin BAAI/bge-small-en-v1.5, disable API embeddings, and disable LLM consolidation.

Upstream: [mnemosyne-oss/mnemosyne](https://github.com/mnemosyne-oss/mnemosyne) · MIT.
