FROM odoo:18.0

USER root

# Copy your Odoo source to a different location
COPY --chown=odoo:odoo ./odoo /opt/odoo-custom

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

# Create directory for Odoo data
RUN mkdir -p /var/lib/odoo && chown -R odoo:odoo /var/lib/odoo

USER odoo

# Set working directory
WORKDIR /opt/odoo-custom

# Run Odoo using odoo-bin from your source
CMD ["python3", "/opt/odoo-custom/odoo-bin", \
     "--addons-path=/opt/odoo-custom/addons,/mnt/extra-addons", \
     "--data-dir=/var/lib/odoo", \
     "--db_host=db", \
     "--db_port=5432", \
     "--db_user=odoo", \
     "--db_password=odoo_secure_password_123"]
