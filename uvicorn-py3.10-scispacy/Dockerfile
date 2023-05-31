FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10

RUN pip3 install -U pip && \
    pip3 install -U requests mysqlclient

RUN pip3 install torch==1.13.1+cpu torchvision==0.14.1+cpu torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cpu && \
    pip3 install transformers==4.26.0 && \
    pip3 install scispacy==0.5.1 && \
    pip3 install --no-cache-dir https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.5.1/en_core_sci_scibert-0.5.1.tar.gz
