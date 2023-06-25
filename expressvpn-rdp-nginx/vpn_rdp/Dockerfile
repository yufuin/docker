FROM ubuntu:22.04

# ----- timezone -----
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y tzdata && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# ----- firefox -----
#RUN apt remove -y firefox
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:mozillateam/ppa && apt update && \
    printf "Package: *\\nPin: release o=LP-PPA-mozillateam\\nPin-Priority: 1001\\n" | tee /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox && \
    apt install -y firefox

# ----- xrdp -----
ARG ROOT_PASSWORD="passwd"
RUN printf ${ROOT_PASSWORD}\\n${ROOT_PASSWORD}\\n | passwd

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y xrdp lxde && \
    echo lxsession -s LXDE -e LXDE > root/.xsession && \
    apt install -y supervisor net-tools git curl && \
    systemctl enable xrdp
EXPOSE 3389

# ----- expressvpn -----
# https://github.com/Misioslav/expressvpn
ARG DEB_PATH="https://www.expressvpn.works/clients/linux/expressvpn_3.48.0.4-1_amd64.deb"
COPY vpn_files/ /expressvpn/

ENV HEALTHCHECK=""
ENV BEARER=""

RUN apt update && \
    apt install -y python3 && DEB_PATH_LAST_NAME=`echo ${DEB_PATH} | python3 -c "import pathlib;print(pathlib.Path(input()).name, end='')"` && \
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends expect curl ca-certificates iproute2 wget jq iptables iputils-ping && \
    wget -q ${DEB_PATH} -O /expressvpn/${DEB_PATH_LAST_NAME} && \
    dpkg -i /expressvpn/${DEB_PATH_LAST_NAME} && \
    sed -i 's/DAEMON_ARGS=.*/DAEMON_ARGS=""/' /etc/init.d/expressvpn && \
    mv /expressvpn/init-expressvpn /etc/init.d/init-expressvpn && chmod 755 /etc/init.d/init-expressvpn && update-rc.d init-expressvpn defaults && \
    mv /expressvpn/ch-root-passwd /etc/init.d/ch-root-passwd && chmod 755 /etc/init.d/ch-root-passwd && update-rc.d ch-root-passwd defaults && \
    rm -rf /expressvpn/*.deb
HEALTHCHECK --start-period=600s --timeout=5s --interval=2m --retries=3 CMD bash /expressvpn/healthcheck.sh


# ----- ssh -----
RUN apt update && \
    apt install -y openssh-server && systemctl enable ssh && \
    sed -i "s/^#\?PermitRootLogin.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config


# ----- ca cert for https -----
COPY cert_files/ /certs/
RUN apt update && \
    apt install -y openssl curl nginx less && \
    cd /certs && bash /certs/create_cert.sh && \
    mv /certs/reverse-proxy.conf /etc/nginx/conf.d/ && \
    mkdir /usr/share/ca-certificates/mylocal && cp /certs/localCA.crt /usr/share/ca-certificates/mylocal/localCA.crt && echo mylocal/localCA.crt >> /etc/ca-certificates.conf && update-ca-certificates


STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
