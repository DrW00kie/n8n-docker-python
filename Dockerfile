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
    curl \

# RUN python3 -m pip install --upgrade pip
# Install Python packages globally
# RUN python3 -m pip install \
#    requests \
#    pandas \
#    numpy \
#    beautifulsoup4 \
#    lxml \
#    pyyaml \
#    pydf \
#    PyPDF2 \
#    pdfplumber \
#    reportlab \
#    python-docx \
#    zipfile36 \
#    pendulum

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

#   string-strip-html

#   npm cache clean --force

# Create directory for custom nodes
#RUN mkdir -p /home/node/.n8n/nodes

# Copy the entrypoint script to the container
# COPY docker-entrypoint.sh /
# RUN \
#	mkdir .n8n && \
#	chown node:node .n8n
#ENV SHELL /bin/sh
#ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
USER node
