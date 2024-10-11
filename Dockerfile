ARG VERSION=latest

FROM n8nio/n8n:${VERSION}

USER root

# Install Python
RUN apk add --no-cache \
    gcc \
    python3 \
    python3-dev \
    py3-pip && \
    git \
    openssh \
    graphicsmagick \
    tini \
    tzdata \
    ca-certificates \
    libc6-compat \
    jq \
    build-base \
    curl

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
    pdf-lib

USER node
