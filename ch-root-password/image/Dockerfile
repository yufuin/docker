FROM ubuntu:22.04

# ----- ssh -----
RUN apt update && \
    apt install -y openssh-server && systemctl enable ssh && \
    sed -i "s/^#\?PermitRootLogin.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config

# ----- password -----
COPY ch-root-passwd /etc/init.d/ch-root-passwd
RUN mkdir -p /secrets && echo "passwd" > /secrets/password && \
    bash -c "ROOT_PASSWORD=\`python3 -c \"print(open('/secrets/password').readline().strip(), end='')\"\`; printf \${ROOT_PASSWORD}\\\\n\${ROOT_PASSWORD}\\\\n | passwd" && \
    chmod 755 /etc/init.d/ch-root-passwd && update-rc.d ch-root-passwd defaults

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
