FROM debian:bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    dirmngr \
    fonts-noto-cjk \
    gnupg \
    libldap2-dev \
    libpq-dev \
    libsasl2-dev \
    libssl-dev \
    node-less \
    npm \
    python3 \
    python3-dev \
    python3-pip \
    python3-wheel \
    python3-venv \
    xz-utils \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install rtlcss (for RTL support)
RUN npm install -g rtlcss

# Create odoo user
RUN useradd -m -d /var/lib/odoo -s /bin/bash odoo

# Copy Odoo source
COPY --chown=odoo:odoo ./odoo /opt/odoo

# Install Python dependencies with proper flags
WORKDIR /opt/odoo
RUN pip3 install --no-cache-dir --break-system-packages \
    wheel setuptools && \
    pip3 install --no-cache-dir --break-system-packages \
    -r /opt/odoo/requirements.txt

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

# Set proper permissions
RUN chown -R odoo:odoo /var/lib/odoo /opt/odoo /mnt/extra-addons

# Switch to odoo user
USER odoo

# Expose Odoo port
EXPOSE 8069 8072

# Set working directory
WORKDIR /opt/odoo

# Run Odoo
CMD ["python3", "odoo-bin", \
     "--addons-path=/opt/odoo/addons,/mnt/extra-addons", \
     "--db_host=db", \
     "--db_port=5432", \
     "--db_user=odoo", \
     "--db_password=.|jC]5=hsrXe+j)5"]
