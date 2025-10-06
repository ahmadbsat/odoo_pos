FROM odoo:18.0

USER root

# Copy Odoo source contents
COPY --chown=odoo:odoo ./odoo/. /opt/odoo-custom/

# Debug: List what was actually copied
RUN echo "=== Checking /opt/odoo-custom contents ===" && \
    ls -la /opt/odoo-custom/ && \
    echo "=== Looking for odoo-bin ===" && \
    find /opt/odoo-custom -name "odoo-bin" -type f

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

# Create directory for Odoo data
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

USER odoo

# Set working directory
WORKDIR /opt/odoo-custom

# Run Odoo
CMD ["python3", "odoo-bin", \
     "--addons-path=/opt/odoo-custom/addons,/mnt/extra-addons", \
     "--data-dir=/var/lib/odoo", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
