#!/usr/bin/env bash
set -euo pipefail

# Retorna o número de containers Docker em execução.
# Em caso de ausência do Docker ou daemon indisponível, retorna 0.

if ! command -v docker >/dev/null 2>&1; then
    echo 0
    exit 0
fi

# Conta containers com status=running; se o daemon não estiver ativo, retorna 0.
count=$(docker ps --filter status=running --quiet 2>/dev/null | grep -c . || true)
echo "${count}"


