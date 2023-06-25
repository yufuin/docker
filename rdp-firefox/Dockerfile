FROM ubuntu:22.04

ARG ROOT_PASSWORD="passwd"
RUN printf ${ROOT_PASSWORD}\\n${ROOT_PASSWORD}\\n | passwd

# firefox
#RUN apt remove -y firefox
RUN apt update && apt install -y software-properties-common && \
    add-apt-repository -y ppa:mozillateam/ppa && apt update && \
    printf "Package: *\\nPin: release o=LP-PPA-mozillateam\\nPin-Priority: 1001\\n" | tee /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox && \
    apt install -y firefox

# xrdp
RUN apt update && \
    apt install -y tzdata && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && \
    DEBIAN_FRONTEND=noninteractive apt install -y xrdp lxde && \
    echo lxsession -s LXDE -e LXDE > root/.xsession && \
    apt install -y supervisor net-tools git curl && \
    systemctl enable xrdp
EXPORT 3389

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
