# Usage
```bash
docker build -t https_nginx ./image
docker run -d --rm --name https_server \
    -e ORG_NAME=MyOrgName -e SERVER_NAME=localhost -e ALT_IP=127.0.0.1 \
    -v `pwd`/certs:/certs -v `pwd`/config/nginx:/etc/nginx/conf.d \
    -p 8443:443 \
    https_nginx
curl https://localhost:8443 --cacert `pwd`/certs/localCA.crt
docker logs https_server # show log
docker stop https_server # stop server
```

## 特に重要な設定
- docker run実行時のマウント先ディレクトリ
    - /certs/
        - ssl証明書の格納先ディレクトリ．実行時は空でもよく，すでに必要なファイルが存在している場合は証明書ファイルの作成がスキップされる
        - マウントしていない場合はコンテナが終了する
        - 生成されるファイル
            - ssl_certificate: `localhost.crt`
            - ssl_certificate_key: `localhost.key`
            - CA証明書: `localCA.crt`
    - /etc/nginx/conf.d
        - nginxの設定ディレクトリ．コマンド例ではあらかじめ用意してある`config/nginx/ssl.conf`ファイルを利用するようその親ディレクトリをマウントしている
- docker run実行時の環境変数
    - ORG_NAME
        - localCA.crt等に登録される組織名．
    - SERVER_NAME
        - DNSで解決されるサーバー名
    - ALT_IP
        - IPアドレスでアクセスするつもりなら設定が必要

# 挙動
1. /certsディレクトリの存在確認
    - docker run時にマウントが必須
    - 存在しない（マウントされていない）場合，以後の処理を行わずコンテナの処理が終了される
1. /certsディレクトリ内にssl証明書の一式を作成
    - すでに作成済みの場合はスキップされる
1. nginxの実行
1. `tail -f /var/log/nginx/access.log`の実行
