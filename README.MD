# Agentes Azure


## Agente instalado en el servidor

Para este opcion se tiene el agente corriendo en el servidor, con el archivo agent.sh realiza los pasos automaticamente para poder instalar el agente

*Instalar una VM → ejecutar el [script](agent.sh)*

```bash 
sudo ./svc.sh status    # ver si está corriendo
sudo ./svc.sh stop      # detener
sudo ./svc.sh start     # iniciar
sudo ./svc.sh restart   # reiniciar
sudo ./svc.sh uninstall # desinstalar el servicio
```

## Agentes en Docker

Correr agentes en contenedores, todos apuntando al mismo pool, pero con nombres diferentes para ejecutar jobs en paralelo. en la [documentacion oficial](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops) explica las formas de hacerlo para imagenes windows y linux.

[*Ejemplo en linux*](docker)

#### Build de la imagen

```bash
docker build -t dockeragent:latest .
```
#### Deploy del agente

```bash 
docker run --name docker-agent-01 -d \
  -e AZP_URL=https://dev.azure.com/TU_ORG \
  -e AZP_TOKEN=TU_PAT \
  -e AZP_POOL=TuPool \
  -e AZP_AGENT_NAME=docker-agent-01 \
  dockeragent:latest 
```