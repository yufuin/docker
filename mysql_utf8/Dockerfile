FROM mysql:5.7
RUN touch /etc/mysql/conf.d/utf8.cnf && \
    echo "[mysqld]" >> /etc/mysql/conf.d/utf8.cnf && \
    echo "character-set-server=utf8" >> /etc/mysql/conf.d/utf8.cnf && \
    echo "collation-server = utf8_unicode_ci" >> /etc/mysql/conf.d/utf8.cnf && \
    echo "skip-character-set-client-handshake" >> /etc/mysql/conf.d/utf8.cnf && \
    echo >> /etc/mysql/conf.d/utf8.cnf && \
    echo "[client]" >> /etc/mysql/conf.d/utf8.cnf && \
    echo default-character-set=utf8 >> /etc/mysql/conf.d/utf8.cnf
RUN touch /etc/mysql/conf.d/skip_ssl.cnf & \
    echo "[mysqld]" >> /etc/mysql/conf.d/skip_ssl.cnf && \
    echo "skip_ssl" >> /etc/mysql/conf.d/skip_ssl.cnf
