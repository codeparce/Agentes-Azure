FROM ubuntu:22.04
ENV TARGETARCH="linux-x64"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    jq curl git libicu70 tar \
    && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Establecer el directorio de trabajo
WORKDIR /azp

# Copiar script de inicio
COPY start.sh .
COPY setup.sh /tmp/setup.sh
RUN sed -i 's/\r$//' start.sh  && chmod +x start.sh 

# Usuario root
ENV PATH="/root/n/bin:${PATH}"
ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ["/azp/start.sh"]