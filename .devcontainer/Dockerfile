FROM debian:bookworm

# The version of Go can be customized
ARG GO_VERSION=1.25.4
ARG USERNAME=remote

# Create a non-root user with the same UID/GID as the host user to avoid permission issues
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install sudo first to be able to create the user
RUN apt-get update -y && apt-get install -y sudo
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV PATH=/usr/local/go/bin:$PATH
ENV GOPATH=/home/$USERNAME/go
ENV GOBIN=$GOPATH/bin
ENV PATH=$GOBIN:$PATH

# Install packages
RUN apt-get install -y \
    curl \
    wget \
    build-essential \
    cmake \
    git \
    ca-certificates \
    #
    # Install Go
    && wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz \
    #
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN go install golang.org/x/tools/gopls@latest \
    && go install github.com/go-delve/delve/cmd/dlv@latest \ 
    && go install golang.org/x/tools/cmd/goimports@latest \
    && go install honnef.co/go/tools/cmd/staticcheck@latest \
    && go install github.com/fatih/gomodifytags@latest \
    && go install github.com/josharian/impl@latest \
    && go install github.com/cweill/gotests/...@latest

# Switch to non-root user
USER $USERNAME
