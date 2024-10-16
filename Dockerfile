ARG VERSION=latest

FROM n8nio/n8n:${VERSION}

USER root

# Install Python
RUN apk add \
    gcc \
    python3 \
    python3-dev \
    py3-pip \
    git \
    openssh \
    graphicsmagick \
    tini \
    tzdata \
    ca-certificates \
    libc6-compat \
    jq \
    build-base \
    curl && \
    rm -rf /var/cache/apk/*

# Install npm packages globally
RUN npm install -g \
    axios \
    async \
    safer-buffer \
    easy-template-x \
    @xmldom/xmldom \
    jsonata \
    iconv-lite \
    lodash.get \
    jszip \
    json5 \
    tmp \
    moment \
    lodash \
    carbone \
    jspdf \
    pdfkit \
    jspdf-autotable \
    @types/node \
    pdfjs-dist \
    jmespath \
    tempy \
    ajv \
    ajv-formats \
    libreoffice-convert \
    entities \
    pdf-lib && \
    npm cache clean --force

USER node

# Install the custom nodes
WORKDIR /.n8n/nodes
RUN npm install \
    n8n-nodes-python \
    n8n-nodes-carbonejs \
    @cdmx/n8n-nodes-input-validator \
    @flagbit/n8n-nodes-data-validation \
    n8n-nodes-data-validation \
    n8n-nodes-generate-report-2 \
    n8n-nodes-jsonata \
    n8n-python-hari2 \
    n8n-nodes-readpdfform \
    n8n-nodes-writepdfform \
    n8n-nodes-text-manipulation
