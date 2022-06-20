FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

RUN mkdir /root/work/

RUN sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list.d/* && \
    sed -i '/developer\.download\.nvidia\.com\/compute\/machine-learning\/repos/d' /etc/apt/sources.list.d/* && \
    apt-key del 7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub

RUN apt update && apt install -y less sudo
RUN apt install -y language-pack-ja && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && ldconfig
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8
ENV CUDA_VISIBLE_DEVICES 0

RUN apt install -y python3 python3-pip python3-protobuf && ldconfig && \
    pip3 install -U pip && \
    pip3 install tqdm numpy pandas sklearn && \
    pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html && \
    pip3 install torch_optimizer sentencepiece transformers==4.17.0 && \
    pip3 install boto3 requests regex && \
    ldconfig

RUN apt update && apt install -y libmysqlclient-dev && pip3 install mysqlclient && \
    pip3 install optuna && \
    ldconfig

COPY deberta-preprocess /root/work/deberta-preprocess
RUN cd /root/work/deberta-preprocess && python3 run.py

RUN pip3 install -U datasets tensorboard && pip3 install -U wandb && pip3 install -U requests && ldconfig

ARG WANDB_KEY=""
RUN python3 -c "import wandb; wandb.login(key='${WANDB_KEY}')"

RUN rm -r /root/work

WORKDIR /root
CMD ["bash"]
