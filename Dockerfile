FROM python:3.11-slim

USER root

# Install all system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc git curl nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf
RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb && \
    apt-get update && \
    apt-get install -y ./wkhtmltox.deb && \
    rm wkhtmltox.deb

# Create odoo user
RUN useradd -m odoo

# Set working directory
WORKDIR /opt/odoo

# Copy EVERYTHING from repo
COPY --chown=odoo:odoo . .

# Verify what we got
RUN ls -la /opt/odoo && \
    ls -la /opt/odoo/odoo

# Install Python requirements
RUN pip3 install -r /opt/odoo/odoo/requirements.txt

# Switch to odoo user
USER odoo

# Run odoo-bin
CMD ["python3", "/opt/odoo/odoo-bin", \
     "--addons-path=/opt/odoo/odoo/addons,/opt/odoo/addons", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
