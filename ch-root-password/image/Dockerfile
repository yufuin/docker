FROM ubuntu:22.04

# ----- password -----
ARG DEFAULT_ROOT_PASSWORD="passwd"
COPY ch-root-passwd /etc/init.d/ch-root-passwd
RUN mkdir -p /secrets && echo ${DEFAULT_ROOT_PASSWORD} > /secrets/password && \
    bash -c "ROOT_PASSWORD=\`cat /secrets/password | tr -d '\\n'\`; printf \${ROOT_PASSWORD}\\\\n\${ROOT_PASSWORD}\\\\n | passwd" && \
    chmod 755 /etc/init.d/ch-root-passwd && update-rc.d ch-root-passwd defaults

# ----- ssh -----
RUN apt update && \
    apt install -y openssh-server && systemctl enable ssh && \
    sed -i "s/^#\?PermitRootLogin.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
