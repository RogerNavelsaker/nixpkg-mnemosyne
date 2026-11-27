#!/usr/bin/env bash
# Bump nix/package.nix to the latest mnemosyne-memory sdist on PyPI (version, hash-scoped URL, hash).
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
pkg=nix/package.nix
json=$(curl -fsS https://pypi.org/pypi/mnemosyne-memory/json)
new=$(jq -r .info.version <<<"$json")
old=$(grep -oE '^  version = "[^"]+"' $pkg | sed -E 's/.*"([^"]+)"/\1/')
[ "$new" != "$old" ] || { echo "up to date: $old"; exit 0; }
url=$(jq -r '.urls[]|select(.packagetype=="sdist")|.url' <<<"$json")
sri=$(nix hash convert --hash-algo sha256 --to sri "$(jq -r '.urls[]|select(.packagetype=="sdist")|.digests.sha256' <<<"$json")")
oldurl=$(grep -oE 'url = "[^"]+"' $pkg | sed -E 's/url = "([^"]+)"/\1/')
sed -i -E \
  -e "s|^  version = \"$old\"|  version = \"$new\"|" \
  -e "s|$oldurl|$url|" \
  -e "s|mnemosyne_memory-$old.tar.gz|mnemosyne_memory-$new.tar.gz|" \
  -e "s|(hash = )\"sha256-[^\"]+\"|\1\"$sri\"|" $pkg
echo "bumped $old -> $new"
