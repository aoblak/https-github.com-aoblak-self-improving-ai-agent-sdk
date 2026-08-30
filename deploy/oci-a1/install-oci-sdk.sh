#!/usr/bin/env bash
set -euo pipefail

PYTHON_BIN="${PYTHON_BIN:-python3}"
VENV_DIR="${OCI_VENV_DIR:-$HOME/.venvs/oci}"

command -v curl >/dev/null || { echo 'curl is required'; exit 1; }
command -v "$PYTHON_BIN" >/dev/null || { echo "$PYTHON_BIN is required"; exit 1; }

mkdir -p "$HOME/.local/bin" "$(dirname "$VENV_DIR")"

# Oracle OCI CLI official installer
bash -c "$(curl -fsSL https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
  --accept-all-defaults \
  --exec-dir "$HOME/.local/bin"

"$PYTHON_BIN" -m venv "$VENV_DIR"
"$VENV_DIR/bin/pip" install --upgrade pip oci

printf '\nInstalled OCI CLI and Python SDK.\n'
printf 'Add to PATH if needed: export PATH="$HOME/.local/bin:$PATH"\n'
printf 'Configure CLI: oci setup config\n'
printf 'Verify SDK: %s/bin/python -c "import oci; print(oci.__version__)"\n' "$VENV_DIR"
