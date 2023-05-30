#!/bin/bash
pushd /certs/ > /dev/null && \
bash /scripts/create_cert.sh && \
popd > /dev/null

nginx
# nginx -s reload
echo "start server"

exec tail -f /var/log/nginx/access.log
