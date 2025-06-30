FROM debian:stable-slim

ARG DEFAULT_USER=rustdev

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install --no-install-recommends -y \
    sudo \
    ca-certificates \
    curl \
    git \
    gh \
    file \
    build-essential \
    autoconf \
    automake \
    autotools-dev \
    libtool \
    xutils-dev && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -s /bin/bash $DEFAULT_USER && \
    usermod -aG sudo $DEFAULT_USER

USER $DEFAULT_USER
ENV HOME=/home/$DEFAULT_USER
ENV PATH=$HOME/.cargo/bin:$PATH
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN rustup component add rustfmt clippy
RUN cargo install rustlings