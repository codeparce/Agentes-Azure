#!/bin/bash
set -e

# setup.sh instala herramientas (Terraform, Node, SWA CLI). Debe ir antes:
# start.sh levanta el agente y bloquea hasta detener el contenedor.
/tmp/setup.sh
exec /azp/start.sh "$@"
