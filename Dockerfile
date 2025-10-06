FROM odoo:18.0

USER root

# Copy entire repository root (which contains odoo-bin)
COPY --chown=odoo:odoo . /opt/odoo-custom/

# Create directory for Odoo data
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

# Make odoo-bin executable
RUN chmod +x /opt/odoo-custom/odoo-bin

USER odoo

# Set working directory
WORKDIR /opt/odoo-custom

# Run Odoo
CMD ["python3", "odoo-bin", \
     "--addons-path=/opt/odoo-custom/odoo/addons,/opt/odoo-custom/addons", \
     "--data-dir=/var/lib/odoo", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
