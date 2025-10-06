FROM odoo:18.0

USER root

# Copy your Odoo source (overwrites the default)
COPY --chown=odoo:odoo ./odoo /usr/lib/python3/dist-packages/odoo

# Copy custom addons
COPY --chown=odoo:odoo ./addons /mnt/extra-addons

USER odoo

# Run Odoo
CMD ["odoo", "--addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons"]
