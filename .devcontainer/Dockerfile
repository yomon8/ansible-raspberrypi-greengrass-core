FROM python:3.8.3-slim-buster

RUN apt update && apt install -y git sshpass
RUN pip install ansible==2.9.10

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN mkdir -p /home/$USERNAME \
    && useradd -s /bin/bash $USERNAME \
    && groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME
