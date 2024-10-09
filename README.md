# n8n-docker-caddy (Customized Version)

This repository provides a customized setup for running **n8n** using Docker and Caddy, based on the original `n8n-docker-caddy` repository. The following documentation explains the changes made to adapt the environment, including additional packages, dependencies, and modifications to make it more versatile.

## Platforms Supported

* [DigitalOcean tutorial](https://docs.n8n.io/hosting/server-setups/digital-ocean/)
* [Hetzner Cloud tutorial](https://docs.n8n.io/hosting/server-setups/hetzner/)

If you have questions after trying the tutorials, check out the [forums](https://community.n8n.io/).

## Prerequisites

Self-hosting n8n requires technical knowledge, including:

* Setting up and configuring servers and containers
* Managing application resources and scaling
* Securing servers and applications
* Configuring n8n

n8n recommends self-hosting for expert users. Mistakes can lead to data loss, security issues, and downtime. If you aren't experienced at managing servers, consider using [n8n Cloud](https://n8n.io/cloud/).

## Customizations Made

### Extra Software and Packages Installed

#### Python Installation
* **Python Version**: Python 3 (installed via `apt-get`).
* **Installed Python Packages**:
  - `requests`
  - `pandas`
  - `fire`
  - `numpy`
  - `beautifulsoup4`
  - `lxml`
  - `pyyaml`
  - `pydf`
  - `PyPDF2`
  - `pdfplumber`
  - `reportlab`
  - `python-docx`
  - `zipfile36`
  - `pendulum`

#### npm Packages Installed
* Global npm packages installed via `npm install -g`:
  - `axios`
  - `async`
  - `safer-buffer`
  - `easy-template-x`
  - `@xmldom/xmldom`
  - `jsonata`
  - `iconv-lite`
  - `lodash.get`
  - `jszip`
  - `json5`
  - `tmp`
  - `moment`
  - `lodash`
  - `carbone`
  - `jspdf`
  - `pdfkit`
  - `jspdf-autotable`
  - `@types/node`
  - `pdfjs-dist`
  - `JMESPath`
  - `tempy`
  - `ajv`
  - `ajv-formats`
  - `libreoffice-convert`
  - `entities`
  - `pdf-lib`
  - `string-strip-html`

#### Custom n8n Nodes Installed
The following community nodes have been added to extend n8n functionality:
* `n8n-nodes-python`
* `n8n-nodes-carbonejs`
* `@cdmx/n8n-nodes-input-validator`
* `@flagbit/n8n-nodes-data-validation`
* `n8n-nodes-data-validation`
* `n8n-nodes-generate-report-2`
* `n8n-nodes-jsonata`
* `n8n-python-hari2`
* `n8n-nodes-readpdfform`
* `n8n-nodes-writepdfform`
* `n8n-nodes-text-manipulation`

### Changes to Dockerfile
* Added installation for **Python 3** using `apt-get`.
* Installed various **Python dependencies** globally to support custom workflows.
* Installed multiple **npm packages** globally to support additional functionality within n8n workflows.
* Created a new directory for custom nodes (`/home/node/.n8n/nodes`) and installed custom n8n nodes.
* Set appropriate permissions for directories to ensure proper access by the `node` user.
* Added tools such as **GraphicsMagick** (`graphicsmagick`) and **7zip** (`p7zip-full`) for extended processing capabilities.

### Changes to `docker-compose.yml`
* Updated to use a customized image (`n8n-docker-caddy-python:latest`) built from the modified Dockerfile.
* Added a new volume for **downloaded files** (`/files/downloads`) to ensure persistent storage of downloaded assets such as PDFs.
* Defined a **custom network** (`n8n_network`) to allow seamless communication between the `caddy` and `n8n` services.
* Set environment variables to control the behavior of n8n and enable additional features (e.g., allowing built-in modules and external packages).
* Added volumes for **persistent storage**:
  - **`caddy_data`**: Stores Caddy data such as SSL certificates.
  - **`n8n_data`**: Stores n8n configuration and workflow data.
  - **`n8n_downloads`**: Stores downloaded files for later access.

### Changes to Environment Variables
* **`NODE_FUNCTION_ALLOW_EXTERNAL=true`**: Enables the use of external npm packages in function nodes.
* **`NODE_FUNCTION_ALLOW_BUILTIN=true`**: Allows using built-in Node.js modules (e.g., `fs`, `path`).
* **`N8N_BLOCK_ENV_ACCESS_IN_NOD=false`**: Allows function nodes to access environment variables.
* **`N8N_COMMUNITY_PACKAGES_ENABLED=true`**: Enables the installation and use of community-created nodes.
* **`N8N_DEFAULT_BINARY_DATA_MODE=filesystem`**: Set to store binary data on the file system, reducing memory usage during workflows that involve binary data (e.g., PDFs).

### Summary of DigitalOcean Installation Steps
For more details on installation, refer to the [DigitalOcean tutorial](https://docs.n8n.io/hosting/installation/server-setups/digital-ocean/). Here is a brief summary of the steps needed to set up `n8n-docker-caddy` on DigitalOcean:

1. **Create a Droplet**: Create a new droplet with sufficient resources (2GB RAM recommended for basic usage).
2. **Install Docker**: Set up Docker by running the installation script provided by Docker.
3. **Clone the Repository**: Clone this customized repository (`n8n-docker-caddy`) to get started.
4. **Update Environment Variables**: Edit the `.env` file to configure domain, subdomain, and other settings.
5. **Run Docker Compose**: Use `docker-compose up -d` to start the Caddy and n8n services.
6. **Access n8n**: Once setup is complete, access n8n at `https://<subdomain>.<domain>`.

## Version History

### Version 1.0.0
* Initial customized setup based on `n8n-docker-caddy` repository.
* Installed additional software and packages, including Python 3, various Python dependencies, and global npm packages.
* Added several custom n8n nodes to enhance workflow capabilities.
* Set up Docker volumes for persistent storage of configuration, data, and downloaded files.
* Running as `root` user initially, with plans to migrate to a non-root user once the setup is running smoothly.
* Likely redundent packages at install, I need to research the core n8n packages installed
