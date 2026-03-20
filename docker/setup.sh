#!/bin/bash
# =============================================================================
# Setup de herramientas para desarrollo local y despliegue en contenedor.
# =============================================================================
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# =============================================================================
# 1. Dependencias base
# =============================================================================
echo "1. Dependencias base"

apt-get update -qq
apt-get install -y -qq \
  ca-certificates curl gnupg wget lsb-release \
  libicu-dev libssl-dev unzip make \
  software-properties-common gettext-base
rm -rf /var/lib/apt/lists/*

echo "Dependencias instaladas"

# =============================================================================
# 2. Terraform
# =============================================================================
echo "2. Terraform"

TMP=$(mktemp)
wget -qO "$TMP" https://apt.releases.hashicorp.com/gpg
gpg --batch --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg "$TMP"
rm -f "$TMP"

CODENAME=$(lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com ${CODENAME} main" \
  > /etc/apt/sources.list.d/hashicorp.list

apt-get update -qq
apt-get install -y -qq terraform
rm -rf /var/lib/apt/lists/*

echo "Terraform: $(terraform version | head -1)"

# =============================================================================
# 3. Node.js 24 (via NodeSource — instalación directa sin n-install)
# =============================================================================
echo "3. Node.js 24"

curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt-get install -y -qq nodejs
rm -rf /var/lib/apt/lists/*

echo "Node: $(node --version) | npm: $(npm --version)"

# =============================================================================
# 4. SWA CLI
# =============================================================================
echo "4. Azure SWA CLI"

npm install -g @azure/static-web-apps-cli

echo "SWA: $(swa --version 2>/dev/null || echo instalado)"
