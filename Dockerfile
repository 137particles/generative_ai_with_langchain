# Define a build argument for the architecture
ARG ARCH=amd64
ARG TARGETPLATFORM


# Multi-stage build for different architectures

# Stage for AMD64
FROM ubuntu:20.04 as base-amd64
ENV PLATFORM_SPECIFIC_SCRIPT="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# Stage for ARM64
FROM ubuntu:20.04 as base-arm64
ENV PLATFORM_SPECIFIC_SCRIPT="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh"

# Final stage, using the build argument to select the correct base
FROM base-${ARCH}

# Install prerequisites
RUN apt-get update && apt-get install -y wget build-essential && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda or Miniforge based on the architecture
RUN wget ${PLATFORM_SPECIFIC_SCRIPT} -O miniconda.sh \
    && mkdir /root/.conda \
    && bash miniconda.sh -b -p /root/miniconda3 \
    && rm -f miniconda.sh

# Set the PATH environment variable
ENV PATH=/root/miniconda3/bin:$PATH

# Update conda and check version
RUN conda update -n base -c defaults conda -y && conda --version

# Update the environment
COPY langchain_ai.yaml .
COPY notebooks ./notebooks
RUN conda env update --name base --file langchain_ai.yaml -vv

# Set the working directory
WORKDIR /home

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Set the entry point for running the Jupyter Notebook
ENTRYPOINT ["conda", "run", "-n", "base", "jupyter", "notebook", "--notebook-dir=/notebooks", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
