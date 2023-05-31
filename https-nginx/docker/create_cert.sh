#! /usr/bin/env bash
set -e
# usage:
# ORG_NAME=MyOrgName SERVER_NAME=localhost ALT_IP=127.0.0.1 bash create_cert.sh

# 最終生成ファイル:
# ssl_certificate:     localhost.crt
# ssl_certificate_key: localhost.key
# CA証明書:             localCA.crt

# 参考：https://zenn.dev/jeffi7/articles/10f7b12d6044ad

ORG_NAME=${ORG_NAME:-"MyOrganization"}
SERVER_NAME=${SERVER_NAME:-"localhost"}
ALT_IP=${ALT_IP:-"127.0.0.1"}

STATE=Tokyo
COUNTRY=jp
EMAIL=example-mail@example.com
CA_EXPIRE_DAYS=36500
SERVER_EXPIRE_DAYS=18250

ALT_NAMES="subjectAltName = DNS:localhost, DNS:localhost.localdomain, IP:127.0.0.1"
if [ $SERVER_NAME != "localhost" ]; then
    ALT_NAMES=${ALT_NAMES}", DNS:${SERVER_NAME}"
fi
if [ $ALT_IP != "127.0.0.1" ]; then
    ALT_NAMES=${ALT_NAMES}", IP:${ALT_IP}"
fi

# すでに作成済みなら何もせず終了
if [ -e localhost.crt ] && [ -e localhost.key ] && [ -e localCA.crt ]; then
    exit
fi

# CA用の秘密鍵を生成
openssl genrsa -out localCA.key 2048
# CSRを生成
echo """\
${COUNTRY}
${STATE}

${ORG_NAME}

${SERVER_NAME}
${EMAIL}


""" | openssl req -out localCA.csr -key localCA.key -new
# CA証明書を作成
openssl x509 -req -days ${CA_EXPIRE_DAYS} -signkey localCA.key -in localCA.csr -out localCA.crt

# サーバー用の秘密鍵を生成
openssl genrsa -out localhost.key 2048
# CSRを生成
echo """\
${COUNTRY}
${STATE}

${ORG_NAME}

${SERVER_NAME}
${EMAIL}


""" | openssl req -out localhost.csr -key localhost.key -new
# SANを作成
echo ${ALT_NAMES} > localhost.csx
# サーバー証明書を作成
openssl x509 -req -days ${SERVER_EXPIRE_DAYS} -CA localCA.crt -CAkey localCA.key -CAcreateserial -in localhost.csr -extfile localhost.csx -out localhost.crt

