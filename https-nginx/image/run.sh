#! /usr/bin/env bash
set -e

# make certs
if [ ! -d /certs/ ]; then
    echo 'cannot find "/certs/" directory. try "docker run" with "-v path/to/host/dir:/certs/".'
    echo 'exit...'
    exit
fi
pushd /certs/ > /dev/null && \
bash /create_cert.sh && \
popd > /dev/null

nginx
echo "start server"

exec tail -f /var/log/nginx/access.log
