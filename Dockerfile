# Use Ubuntu 24.04 LTS as the base image with OpenFOAM 12 setup
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

# Install Python3, pip, and the virtual environment module
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv && rm -rf /var/lib/apt/lists/*

# Create a virtual environment in /opt/venv
RUN python3 -m venv /opt/venv

# Add the virtual environment to PATH
ENV PATH="/opt/venv/bin:$PATH"

# Create a non-root user "openfoam" and a simulation directory
RUN useradd -ms /bin/bash openfoam && \
    mkdir -p /home/openfoam/simulation && \
    chown -R openfoam:openfoam /home/openfoam

# Copy the Flask app and requirements, and set permissions
COPY microservice.py /opt/microservice.py
COPY requirements.txt /opt/requirements.txt
RUN chown openfoam:openfoam /opt/microservice.py /opt/requirements.txt

# Install Python dependencies into the virtual environment
RUN pip install --no-cache-dir -r /opt/requirements.txt

# Set working directory to the simulation folder (writable by non-root)
WORKDIR /home/openfoam/simulation

# Expose port 5000 for Flask
EXPOSE 5000

# Switch to the non-root user "openfoam"
USER openfoam

# Run the Flask app with the OpenFOAM environment
CMD ["/bin/bash", "-c", "source /opt/openfoam12/etc/bashrc && python3 /opt/microservice.py"]
