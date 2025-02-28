# Use Ubuntu 24.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV WM_PROJECT_DIR=/opt/openfoam12
ENV WM_DIR=/opt/openfoam12/etc/bashrc

# Update package lists and install prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    software-properties-common \
    gedit \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Add OpenFOAM repository and public key
RUN bash -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc" && \
    add-apt-repository "http://dl.openfoam.org/ubuntu"

# Update package lists again and install OpenFOAM 12
RUN apt-get update && apt-get install -y --no-install-recommends \
    openfoam12 \
    && rm -rf /var/lib/apt/lists/*

# Configure the environment for OpenFOAM globally
RUN echo ". /opt/openfoam12/etc/bashrc" >> /root/.bashrc
RUN echo ". /opt/openfoam12/etc/bashrc" >> /etc/environment

# Set working directory
WORKDIR /root/OpenFOAM/root-12/run

# Set the entrypoint to ensure sourcing happens in every command
ENTRYPOINT ["/bin/bash", "-c", "source /opt/openfoam12/etc/bashrc && exec \"$@\"", "--"]
