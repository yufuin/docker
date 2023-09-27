FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget python2 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /brat && cd /brat && \
    wget https://github.com/nlplab/brat/archive/refs/tags/v1.3p1.tar.gz && \
    tar zxf v1.3p1.tar.gz && rm v1.3p1.tar.gz && cd brat-1.3p1 && \
    printf "brat\npasswd\n\n" | ./install.sh -u && \
    rm -rf data && mkdir /data && ln -s /data ./data && mkdir -p ./work && chmod 777 /data ./work

WORKDIR /brat/brat-1.3p1
CMD [ "python2", "standalone.py" ]

