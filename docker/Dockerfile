FROM ubuntu:22.04
ENV TARGETARCH="linux-x64"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    jq curl git libicu70 tar \
    ca-certificates gnupg wget lsb-release \
    libssl-dev unzip make \
    software-properties-common gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Docker CLI
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && rm get-docker.sh

# Establecer el directorio de trabajo
WORKDIR /azp

# Copiar scripts
COPY start.sh entry.sh .
COPY setup.sh /tmp/setup.sh

RUN sed -i 's/\r$//' start.sh entry.sh /tmp/setup.sh \
  && chmod +x start.sh entry.sh /tmp/setup.sh

# Usuario root
ENV PATH="/root/n/bin:${PATH}"
ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ["/azp/entry.sh"]