# Use the official n8n base image with the specified Node version
ARG NODE_VERSION=20

FROM n8nio/base:${NODE_VERSION}
USER root
ARG N8N_VERSION=latest

RUN if [ -z "$N8N_VERSION" ]; then echo "The N8N_VERSION argument is missing!"; exit 1; fi

LABEL org.opencontainers.image.title="n8n"
LABEL org.opencontainers.image.description="Workflow Automation Tool"
LABEL org.opencontainers.image.source="https://github.com/n8n-io/n8n"
LABEL org.opencontainers.image.url="https://n8n.io"
LABEL org.opencontainers.image.version=${N8N_VERSION}

# Install n8n and remove development dependencies to reduce image size
ENV N8N_VERSION=${N8N_VERSION}
ENV NODE_ENV=production
ENV N8N_RELEASE_TYPE=stable
RUN set -eux; \
    npm install -g --omit=dev n8n@${N8N_VERSION} --ignore-scripts && \
    npm rebuild --prefix=/usr/local/lib/node_modules/n8n sqlite3 && \
    rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/chat && \
    rm -rf /usr/local/lib/node_modules/n8n/node_modules/n8n-design-system && \
    rm -rf /usr/local/lib/node_modules/n8n/node_modules/n8n-editor-ui/node_modules && \
    find /usr/local/lib/node_modules/n8n -type f -name "*.ts" -o -name "*.js.map" -o -name "*.vue" | xargs rm -f && \
    npm cache clean --force && \
    rm -rf /root/.npm

# Install fonts and dependencies
#RUN apk --no-cache add --virtual fonts msttcorefonts-installer fontconfig && \
#    update-ms-fonts && \
#    fc-cache -f && \
#    apk del fonts && \
#    find /usr/share/fonts/truetype/msttcorefonts/ -type l -exec unlink {} \;

# Install Python
RUN apk add --no-cache \
    gcc \
    python3 \
    python3-dev \
    py3-pip && \
    rm -rf /var/cache/apk/*
#    git \
#    openssh \
#    graphicsmagick \
#    tini \
#    tzdata \
#    ca-certificates \
#    libc6-compat \
#    jq \
#    build-base \
#    curl \
#    py7zip
RUN python3 -m pip install --upgrade pip
# Install Python packages globally
RUN python3 -m pip install \
    requests \
    pandas \
    numpy \
    beautifulsoup4 \
    lxml \
    pyyaml \
    pydf \
    PyPDF2 \
    pdfplumber \
    reportlab \
    python-docx \
    zipfile36 \
    pendulum

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
    pdf-lib \
    string-strip-html && \
    npm cache clean --force

# Create directory for custom nodes
#RUN mkdir -p /home/node/.n8n/nodes

# Copy the entrypoint script to the container
COPY docker-entrypoint.sh /
RUN \
	mkdir .n8n && \
	chown node:node .n8n
ENV SHELL /bin/sh
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
USER node
