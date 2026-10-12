#!/bin/sh
# Starts Scaffold's MCP server with a Node new enough for node:sqlite (22.13+).
#
# Apps launched from the Dock don't inherit a terminal's PATH, so a Node that a
# version manager installed is invisible to them. Look where those install, too,
# and take the first one that's new enough.
root="$(cd "$(dirname "$0")/.." && pwd)"

recent_enough() {
  "$1" -e 'const [a,b]=process.versions.node.split(".").map(Number);process.exit(a>22||(a===22&&b>=13)?0:1)' 2>/dev/null
}

for node in "$SCAFFOLD_NODE" "$(command -v node 2>/dev/null)" \
  "$HOME"/.nvm/versions/node/*/bin/node \
  /opt/homebrew/bin/node /usr/local/bin/node /usr/bin/node \
  "$HOME"/.volta/bin/node \
  "$HOME"/.local/share/fnm/node-versions/*/installation/bin/node \
  "$HOME"/.asdf/shims/node "$HOME"/.local/share/mise/shims/node; do
  if [ -n "$node" ] && [ -x "$node" ] && recent_enough "$node"; then
    exec "$node" --no-warnings "$root/server/server.mjs" "$@"
  fi
done

echo "Scaffold needs Node.js 22.13 or newer. Install it from https://nodejs.org, or set SCAFFOLD_NODE to its path." >&2
exit 1
