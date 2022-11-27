FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

ENV TERM xterm-256color

# Below from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user

ARG USERNAME=i7qce
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

RUN yes | unminimize

RUN apt-get install -y ubuntu-standard

RUN apt-get update

RUN apt-get install -y vim
RUN apt-get install -y tmux
RUN apt-get install -y git
RUN apt-get install -y curl

RUN apt-get install -y php

RUN apt-get install -y libopencv-dev
RUN apt-get install -y python3-pip

RUN pip install numpy scipy matplotlib jupyterlab pandas scikit-learn opencv-python ipympl pillow jupyter tqdm pytest


# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN git config --global user.name "i7qce"
RUN git config --global user.email "i7qce@dev-server.local"

RUN ipython kernel install --user --name=dev_kernel

WORKDIR "/home/i7qce/docs"

CMD ["bash", "-l"]
