FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10

RUN pip3 install -U pip && \
    pip3 install -U requests mysqlclient

RUN pip3 install -U scispacy==0.5.1 && pip3 install https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.5.1/en_core_sci_scibert-0.5.1.tar.gz
