FROM ubuntu:22.04

# ----- timezone -----
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y tzdata && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# ----- password -----
ARG DEFAULT_ROOT_PASSWORD="passwd"
COPY ch-root-passwd /etc/init.d/ch-root-passwd
RUN mkdir -p /secrets && echo ${DEFAULT_ROOT_PASSWORD} > /secrets/root_password && \
    bash -c "ROOT_PASSWORD=\`cat /secrets/root_password | tr -d '\\n'\`; printf \${ROOT_PASSWORD}\\\\n\${ROOT_PASSWORD}\\\\n | passwd" && \
    chmod 755 /etc/init.d/ch-root-passwd && update-rc.d ch-root-passwd defaults

# ----- ssh -----
RUN apt update && \
    apt install -y openssh-server && systemctl enable ssh && \
    sed -i "s/^#\?PermitRootLogin.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config

# ----- xrdp -----
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y xrdp lxde && \
    echo lxsession -s LXDE -e LXDE > root/.xsession && \
    apt install -y supervisor net-tools git curl && \
    apt remove -y --purge light-locker && \
    systemctl enable xrdp

# ----- vnc -----
ARG DEFAULT_VNC_PASSWORD="passwd"
ARG DEFAULT_VNC_GEOMETRY="1280x720"
COPY vnc_files/vncserver@1.service /etc/systemd/system/
RUN apt update && \
    apt install -y python3 tigervnc-standalone-server tigervnc-common && \
    apt install -y novnc websockify && \
    mkdir -p /secrets && echo ${DEFAULT_VNC_PASSWORD} > /secrets/vnc_password && \
    mkdir -p /vnc_settings && echo ${DEFAULT_VNC_GEOMETRY} > /vnc_settings/geometry && \
    systemctl enable vncserver@1


STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
