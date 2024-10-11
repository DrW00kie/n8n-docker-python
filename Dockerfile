FROM docker.n8n.io/n8nio/n8n
USER ROOT


RUN apk add --update gcc python3 py3-pip build-base python3-dev curl jq
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install requests pandas sqlalchemy psycopg2-binary
# Install Python
#RUN apk add --no-cache \
#    gcc
#    python3 \
#    python3-dev \
#    py3-pip \
#    build-base \
#    curl \
#    jq

    
#    p7zip && \
#    rm -rf /var/cache/apk/*

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

# Install Python packages globally
#RUN pip3 install --no-cache-dir \
#    requests \
#    pandas \
#    numpy \
#   beautifulsoup4 \
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
    pdf-lib \
    string-strip-html && \
    npm cache clean --force

# Create directory for custom nodes
#RUN mkdir -p /home/node/.n8n/nodes

# Copy the entrypoint script to the container
#COPY docker-entrypoint.sh /
#RUN \
#	mkdir .n8n && \
#	chown node:node .n8n
#ENV SHELL /bin/sh
#ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

# Install the custom nodes
#RUN mkdir /.n8n/nodes
#WORKDIR /.n8n/nodes
#RUN npm install \
#    n8n-nodes-python \
#    n8n-nodes-carbonejs \
#    @cdmx/n8n-nodes-input-validator \
#    @flagbit/n8n-nodes-data-validation \
#    n8n-nodes-data-validation \
#    n8n-nodes-generate-report-2 \
#    n8n-nodes-jsonata \
#    n8n-python-hari2 \
#    n8n-nodes-readpdfform \
#    n8n-nodes-writepdfform \
#    n8n-nodes-text-manipulation
USER node
