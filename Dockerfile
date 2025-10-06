FROM python:3.11-slim-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    dirmngr \
    fonts-noto-cjk \
    gnupg \
    libssl-dev \
    node-less \
    npm \
    python3-num2words \
    python3-pdfminer \
    python3-pip \
    python3-phonenumbers \
    python3-pyldap \
    python3-qrcode \
    python3-renderpm \
    python3-setuptools \
    python3-slugify \
    python3-vobject \
    python3-watchdog \
    python3-xlrd \
    python3-xlwt \
    xz-utils \
    libpq-dev \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Create odoo user
RUN useradd -ms /bin/bash odoo

# Copy Odoo source
COPY --chown=odoo:odoo ./odoo /opt/odoo

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /opt/odoo/requirements.txt

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

# Set permissions
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

# Switch to odoo user
USER odoo

# Expose Odoo port
EXPOSE 8069

# Set working directory
WORKDIR /opt/odoo

# Run Odoo
CMD ["/opt/odoo/odoo-bin", "--addons-path=/opt/odoo/addons,/mnt/extra-addons", "--db_host=db", "--db_user=odoo", "--db_password=odoo_secure_password_123"]
