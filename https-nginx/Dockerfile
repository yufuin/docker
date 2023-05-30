# usage:
# docker run -d --rm -p 8443:443 -v path/to/dest/certs:/certs --name https_server this_image
# curl https://localhost:8443 --cacert path/to/dest/certs/localCA.crt

FROM ubuntu:22.04


# 一部パッケージのインストール時のロケール設定用インタラクションを無効化
ENV DEBIAN_FRONTEND=noninteractive
# 証明書の配置先ディレクトリ
# NOTE: run.sh, ssl.conf中でハードコーディングで参照されているので変更時はそれらも併せて変更する必要あり.
ENV CERTS_DIR="/certs/"
# スクリプトの配置先ディレクトリ
ENV SCRIPTS_DIR="/scripts/"


# ロケールの設定
RUN apt update && \
    apt install -y tzdata && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# パッケージのインストール
RUN apt install -y openssl curl nginx less

# 証明書用ディレクトリの作成
RUN mkdir ${CERTS_DIR}

# スクリプト用ディレクトリの作成
RUN mkdir ${SCRIPTS_DIR}
# 証明書作成スクリプトの配置
COPY create_cert.sh ${SCRIPTS_DIR}
# 実行用スクリプトの配置
COPY run.sh ${SCRIPTS_DIR}

# nginx設定ファイルの配置
COPY ssl.conf /etc/nginx/conf.d/


WORKDIR ${CERTS_DIR}
CMD "/bin/bash" "${SCRIPTS_DIR}/run.sh"
