FROM ubuntu:22.04
ENV TARGETARCH="linux-x64"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    libicu-dev \
    libssl-dev \
    ca-certificates \
    unzip \
    tar \
    && rm -rf /var/lib/apt/lists/*
    
# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Crear usuario no-root para el agente
RUN useradd -m -s /bin/bash azpagent

# Establecer el directorio de trabajo
WORKDIR /azp

# Copiar script de inicio
COPY start.sh .
RUN sed -i 's/\r$//' start.sh && chmod +x start.sh

## Cambiar la propiedad de los archivos al usuario no-root
RUN chown -R azpagent:azpagent /azp /home/azpagent

# Cambiar a usuario no-root
USER azpagent

ENTRYPOINT ["/azp/start.sh"]
#CMD ["/bin/bash"]