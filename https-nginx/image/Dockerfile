# usage:
# docker run -d -e ORG_NAME=MyOrgName -e SERVER_NAME=localhost -e ALT_IP=127.0.0.1 -p 8443:443 -v `pwd`/certs:/certs -v `pwd`/config/nginx:/etc/nginx/conf.d --rm --name https_server this_image
# curl https://localhost:8443 --cacert `pwd`/certs/localCA.crt

FROM ubuntu:22.04

# ssl証明書用設定
ENV ORG_NAME="MyOrganization"
ENV SERVER_NAME="localhost"
ENV ALT_IP="127.0.0.1"

# 証明書の配置先ディレクトリ
# NOTE: dockerコンテナ作成時にホストからのマウント必須
# NOTE: run.sh, ssl.conf中でハードコーディングで参照されているので変更時はそれらも併せて変更する必要あり.
ARG CERTS_DIR="/certs/"


# 一部パッケージのインストール時のロケール設定用インタラクションを無効化
ENV DEBIAN_FRONTEND=noninteractive
# ロケールの設定
RUN apt update && \
    apt install -y tzdata && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# パッケージのインストール
RUN apt install -y openssl curl nginx less

# 証明書作成スクリプトの配置
COPY create_cert.sh /
# 実行用スクリプトの配置
COPY run.sh /

CMD ["/bin/bash", "/run.sh"]
