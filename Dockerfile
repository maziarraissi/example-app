# Use Ubuntu 24.04 LTS as the base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV WM_PROJECT_DIR=/opt/openfoam12
ENV WM_DIR=/opt/openfoam12/etc/bashrc
ENV SIM_DIR=/root/OpenFOAM/root-12/run

# Update package lists and install prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    software-properties-common \
    gedit \
    bash \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Add OpenFOAM repository and public key
RUN bash -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc" && \
    add-apt-repository "deb http://dl.openfoam.org/ubuntu focal main"

# Update package lists again and install OpenFOAM 12
RUN apt-get update && apt-get install -y --no-install-recommends \
    openfoam12 \
    && rm -rf /var/lib/apt/lists/*

# Configure the environment for OpenFOAM globally
RUN echo ". /opt/openfoam12/etc/bashrc" >> /root/.bashrc
RUN echo ". /opt/openfoam12/etc/bashrc" >> /etc/environment

# Create and set the working directory
WORKDIR /root/OpenFOAM/root-12/run

# Ensure the simulation directory exists and is writable
RUN mkdir -p /root/OpenFOAM/root-12/run && chmod -R 777 /root/OpenFOAM/root-12/run

# Install Flask and dependencies inside a virtual environment
RUN python3 -m venv /root/venv
ENV PATH="/root/venv/bin:$PATH"
RUN pip install --no-cache-dir flask requests

# Copy the microservice script into the container
COPY microservice.py /opt/microservice.py

# Expose port 5000 for Flask API
EXPOSE 5000

# Set the entrypoint to ensure sourcing happens in every command
ENTRYPOINT ["/bin/bash", "-c", "source /opt/openfoam12/etc/bashrc && exec \"$@\"", "--"]

# Start the Flask microservice while keeping OpenFOAM environment available
CMD ["python3", "/opt/microservice.py"]
