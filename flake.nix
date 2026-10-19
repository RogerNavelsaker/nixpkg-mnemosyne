{
  description = "Nix package for the local-first Mnemosyne memory CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/b6018f87da91d19d0ab4cf979885689b469cdd41";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mnemosyne = pkgs.callPackage ./nix/package.nix { };
    in
    {
      packages.${system} = {
        default = mnemosyne;
        mnemosyne-memory = mnemosyne;
      };

      checks.${system}.cli-help = pkgs.runCommand "mnemosyne-cli-help" {
        nativeBuildInputs = [ mnemosyne ];
      } ''
        export HOME="$TMPDIR/home"
        export MNEMOSYNE_DATA_DIR="$TMPDIR/mnemosyne/data"
        export HF_HUB_OFFLINE=1
        export TRANSFORMERS_OFFLINE=1
        export MNEMOSYNE_EMBEDDINGS_VIA_API=false
        export MNEMOSYNE_LLM_ENABLED=false
        mkdir -p "$HOME"
        mnemosyne --help > /dev/null
        test -d "$MNEMOSYNE_DATA_DIR"
        touch "$out"
      '';
    };
}
