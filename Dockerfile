FROM odoo:18.0

USER root

# Copy entire repository
COPY --chown=odoo:odoo . /opt/odoo-custom/

# Debug: Verify odoo folder contents
RUN echo "=== Checking /opt/odoo-custom/odoo/ ===" && \
    ls -la /opt/odoo-custom/odoo/ && \
    echo "=== Checking for odoo-bin ===" && \
    ls -la /opt/odoo-custom/odoo-bin

# If odoo folder is empty, fail with clear message
RUN if [ ! -d /opt/odoo-custom/odoo/addons ]; then \
        echo "ERROR: odoo/addons folder is missing!"; \
        exit 1; \
    fi

# Create directory for Odoo data
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

# Make odoo-bin executable
RUN chmod +x /opt/odoo-custom/odoo-bin

USER odoo

WORKDIR /opt/odoo-custom

# Run Odoo
CMD ["python3", "odoo-bin", \
     "--addons-path=/opt/odoo-custom/odoo/addons,/opt/odoo-custom/addons", \
     "--data-dir=/var/lib/odoo", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
