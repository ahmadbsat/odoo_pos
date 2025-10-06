FROM odoo:18.0

USER root

# Copy Odoo source contents (note the trailing /. to copy contents)
COPY --chown=odoo:odoo ./odoo/. /opt/odoo-custom/

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

# Create directory for Odoo data
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

# Make odoo-bin executable
RUN chmod +x /opt/odoo-custom/odoo-bin

USER odoo

# Set working directory
WORKDIR /opt/odoo-custom

# Run Odoo
CMD ["python3", "/opt/odoo-custom/odoo-bin", \
     "--addons-path=/opt/odoo-custom/addons,/mnt/extra-addons", \
     "--data-dir=/var/lib/odoo", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
