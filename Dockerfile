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

# Create odoo config directory
RUN mkdir -p /etc/odoo && chown odoo:odoo /etc/odoo

# Create config file with admin password
RUN echo "[options]" > /etc/odoo/odoo.conf && \
    echo "admin_passwd = admin123" >> /etc/odoo/odoo.conf && \
    echo "db_host = db" >> /etc/odoo/odoo.conf && \
    echo "db_user = odoo" >> /etc/odoo/odoo.conf && \
    echo "db_port = 5432" >> /etc/odoo/odoo.conf && \
    chown odoo:odoo /etc/odoo/odoo.conf

USER odoo

WORKDIR /opt/odoo-repo

CMD ["python3", "/usr/bin/odoo-bin", \
     "-c", "/etc/odoo/odoo.conf", \
     "--addons-path=/usr/lib/python3/dist-packages/odoo/addons,/opt/odoo-repo/addons"]
