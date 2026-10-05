#!/usr/bin/env bash
# Build the PrestaShop-installable zip for twittertimeline.
#
# The zip is what customers actually receive: megventure.com streams the
# on-disk bytes of this archive, so whatever lands here is the product.
# Everything below the "Refuse to ship" line is a hard gate, not advice --
# a full .git/ directory once leaked into nine shipped zips, which published
# the complete commit history of each module to anyone who downloaded one.
#
# Usage: ./tools/pack-dist.sh [output-zip-path]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME=twittertimeline
VERSION="$(sed -n "s/.*\$this->version = '\([^']*\)'.*/\1/p" "$ROOT/$NAME.php")"
[ -n "$VERSION" ] || { echo "ERROR: could not read \$this->version from $NAME.php" >&2; exit 2; }
OUT="${1:-$ROOT/../$NAME-$VERSION.zip}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/$NAME"
# Ship the module only: no VCS metadata, no tests, no packaging tooling.
tar -C "$ROOT" \
  --exclude='./.git' --exclude='./.git/*' \
  --exclude='./.github' --exclude='./.gitignore' --exclude='./.gitattributes' \
  --exclude='./tests' --exclude='./tools' \
  --exclude='./.distignore' --exclude='*~' --exclude='.DS_Store' \
  -cf - . | tar -C "$STAGE/$NAME" -xf -

# ---- Refuse to ship: hard gates, checked against the staged tree ----
fail() { echo "ERROR: $1" >&2; exit 2; }
find "$STAGE/$NAME" -name '.git' -o -name '.github' -o -name '.gitignore' \
  -o -name '.gitattributes' | grep -q . && fail "VCS metadata must not appear in dist"
find "$STAGE/$NAME" -type d -name tests | grep -q . && fail "tests/ must not appear in dist"
find "$STAGE/$NAME" -type d -name tools | grep -q . && fail "tools/ must not appear in dist"
# A BOM before <?php makes every header() in that file a no-op and is an
# Addons validator rejection. Catch it here, not in the validator queue.
while IFS= read -r -d '' f; do
  [ "$(head -c3 "$f" | od -An -tx1 | tr -d ' \n')" = "efbbbf" ] && fail "UTF-8 BOM in ${f#$STAGE/}"
done < <(find "$STAGE/$NAME" -type f -print0)
# PrestaShop reads the version from the main class; the folder must not carry it.
[ -f "$STAGE/$NAME/$NAME.php" ] || fail "$NAME.php missing from dist root"

rm -f "$OUT"
(cd "$STAGE" && zip -rqX "$OUT" "$NAME")
echo "Wrote $OUT ($NAME $VERSION)"
unzip -l "$OUT"
