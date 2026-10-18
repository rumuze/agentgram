# Production-grade multi-stage Dockerfile for Rumuze Edit
# Supports linux/amd64 and linux/arm64
FROM python:3.11-slim AS base

# Install system dependencies & Node.js 20 LTS
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ca-certificates \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install OpenCode CLI globally
RUN curl -fsSL https://opencode.ai/install.sh | bash || true

WORKDIR /app

# Copy application files
COPY package.json LICENSE README.md ./
COPY bin/ ./bin/
COPY core/ ./core/
COPY templates/ ./templates/

# Ensure executable permissions
RUN chmod +x bin/rumuze-edit bin/rumuze-edit.js

# Setup workspace and config directories
RUN mkdir -p /workspace /root/.config/rumuze-edit
WORKDIR /workspace

VOLUME ["/workspace", "/root/.config/rumuze-edit"]

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD python3 -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:4096', timeout=2)" || exit 0

ENTRYPOINT ["node", "/app/bin/rumuze-edit.js"]
CMD ["start", "--dir", "/workspace"]
