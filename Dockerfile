FROM oven/bun:slim

# set some defaults
ENV DEBUG=false

ENV DEBIAN_FRONTEND=noninteractive

VOLUME ["/tmp", "/var/lib/apt", "/var/cache/apt", "/var/tmp"]

# Setup unprivileged user defaults
COPY usr/ /usr/
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gosu && \
    chmod +x /usr/local/sbin/docker-entrypoint.sh

# Install OpenCode CLI
ARG OPENCODE_CLI_VERSION="latest"
ARG TARGETPLATFORM
ENV BUN_INSTALL=/usr/local/bun
RUN mkdir -p /usr/local/bun && \
    chmod -R 755 /usr/local/bun && \
    bun install -g opencode-ai@${OPENCODE_CLI_VERSION} && \
    opencode --version

WORKDIR /home/opencode/workspace
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh", "opencode"]
