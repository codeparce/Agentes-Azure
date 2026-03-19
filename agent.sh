#!/bin/bash
## Crear agente o runner en un servidor

mkdir myagent && cd myagent

# 1. Obtén la URL real desde la UI de Azure DevOps, será algo como:
curl -O https://vstsagentpackage.blob.core.windows.net/agent/4.248.0/vsts-agent-linux-x64-4.248.0.tar.gz

# 2. Extrae (usa el nombre exacto del archivo que descargaste)
tar zxvf vsts-agent-linux-x64-4.248.0.tar.gz

# 3. Configura
./config.sh

# 4. Corre el agente
#./run.sh

# Instala el servicio
sudo ./svc.sh install

# Inicia el servicio
sudo ./svc.sh start

# Verifica que está corriendo
sudo ./svc.sh status