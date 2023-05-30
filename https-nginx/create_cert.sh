# 最終生成ファイル
# ssl_certificate:     localhost.crt
# ssl_certificate_key: localhost.key
# CA証明書:             localCA.crt

# 参考：https://zenn.dev/jeffi7/articles/10f7b12d6044ad
COUNTRY=jp
STATE=Tokyo
ORGANIZATION_NAME=MyOrganization
COMMON_NAME=MyServerName
EMAIL=example-mail@example.com
CA_EXPIRE_DAYS=36500
SERVER_EXPIRE_DAYS=18250

SERVER_NAME=localhost
ALT_NAMES="IP:192.168.0.123"



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

${ORGANIZATION_NAME}

${COMMON_NAME}
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

${ORGANIZATION_NAME}

${SERVER_NAME}
${EMAIL}


""" | openssl req -out localhost.csr -key localhost.key -new
# SANを作成
echo "subjectAltName = DNS:localhost, DNS:localhost.localdomain, IP:127.0.0.1, ${ALT_NAMES}" > localhost.csx
# サーバー証明書を作成
openssl x509 -req -days ${SERVER_EXPIRE_DAYS} -CA localCA.crt -CAkey localCA.key -CAcreateserial -in localhost.csr -extfile localhost.csx -out localhost.crt

