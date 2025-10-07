FROM odoo:18.0

USER root

# Remove default Odoo installation
RUN rm -rf /usr/lib/python3/dist-packages/odoo

# Copy your entire repo
COPY --chown=odoo:odoo . /opt/odoo-repo

# Create symbolic link so Python can find odoo module
RUN ln -s /opt/odoo-repo/odoo /usr/lib/python3/dist-packages/odoo

# Copy odoo-bin to standard location
RUN cp /opt/odoo-repo/odoo-bin /usr/bin/odoo-bin && chmod +x /usr/bin/odoo-bin

USER odoo

WORKDIR /opt/odoo-repo

CMD ["python3", "/usr/bin/odoo-bin", \
     "--addons-path=/usr/lib/python3/dist-packages/odoo/addons,/opt/odoo-repo/addons", \
     "--db_host=db", \
     "--db_user=odoo", \
     "--db_password=mySecurePassword123"]
