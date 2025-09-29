FROM ubuntu:24.04

ARG USERNAME=remote
ARG USER_UID=1001
ARG USER_GID=$USER_UID
ARG GO_VERSION=1.25.1

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN \
    # Create a non-root user to avoid running as root
    groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # 
    && apt-get update -y \
    # 
    && apt-get install -y \
    sudo \
    curl \
    wget \
    build-essential \
    cmake \
    git \
    ca-certificates \
    #
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Install Go
    && wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz \
    #
    # Clean up apt cache to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/go/bin:$PATH
ENV GOPATH=/home/$USERNAME/go
ENV GOBIN=$GOPATH/bin
ENV PATH=$GOBIN:$PATH

# Reset DEBIAN_FRONTEND
ENV DEBIAN_FRONTEND=

# Set the default user
USER $USERNAME

# Verify Go installation
RUN go version
