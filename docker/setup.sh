#!/bin/bash
# =============================================================================
# Ejecutar dentro del contenedor para tener las herramientas necesarias para el desarrollo local y despliegue
# La forma ansible esta con inconvenientes, así que se hace manualmente
# =============================================================================
set -euo pipefail

# ── Colores para output ───────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}[OK]${NC}    $*"; }
info() { echo -e "${CYAN}[INFO]${NC}  $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
fail() { echo -e "${RED}[FAIL]${NC}  $*"; exit 1; }

header() {
  echo ""
  echo -e "${CYAN}─────────────────────────────────────────────${NC}"
  echo -e "${CYAN}  $*${NC}"
  echo -e "${CYAN}─────────────────────────────────────────────${NC}"
}

# =============================================================================
# 1. Dependencias base
# =============================================================================
header "1. Instalando dependencias base"

apt-get install -y \
  libicu-dev \
  libssl-dev \
  ca-certificates \
  unzip \
  make \
  gnupg \
  wget \
  lsb-release \
  software-properties-common \
  gettext-base \
  && rm -rf /var/lib/apt/lists/*

ok "Dependencias base instaladas"

# =============================================================================
# 2. Terraform
# =============================================================================
header "2. Instalando Terraform"

wget -O - https://apt.releases.hashicorp.com/gpg |  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list

apt update &&  apt install terraform


# =============================================================================
# 3. Node.js
# =============================================================================
curl -fsSL https://raw.githubusercontent.com/mklement0/n-install/stable/bin/n-install | bash -s 24 --y


# =============================================================================
# 4. Azure Static Web Apps CLI (swa)
# =============================================================================
header "4. Instalando SWA CLI"

npm install -g @azure/static-web-apps-cli



