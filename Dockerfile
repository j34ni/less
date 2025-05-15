FROM quay.io/condaforge/miniforge3:24.11.3-2

# Create Conda environment with required packages
RUN mamba create -y -n less -c conda-forge \
    cmake \
    liblapack \
    libblas \
    libiconv \
    libpng \
    libxml2 \
    pkg-config \
    r-base=4.4.2 \
    tzdata \
    udunits2 \
    xz \
    zlib \
    gfortran_linux-64 \
    freetype \
    fontconfig \
    cairo && \
    mamba clean -afy

# Set environment
ENV PATH="/opt/conda/envs/less/bin:$PATH" \
    PKG_CONFIG_PATH="/opt/conda/envs/less/lib/pkgconfig" \
    LDFLAGS="-L/opt/conda/envs/less/lib" \
    CPPFLAGS="-I/opt/conda/envs/less/include" \
    TZ="Europe/Oslo"

# Install R packages from CRAN
RUN R -e "install.packages(c('units', 'janitor', 'ggtext', 'MuMIn', 'ggplot2', 'lme4', 'purrr', 'readxl', 'sjPlot', 'tidyr', 'nloptr'), repos='https://cran.uib.no/')"

# Copy the start.sh script
COPY ./start.sh /opt/less/start.sh

# Set the entrypoint to the start.sh script
ENTRYPOINT ["/opt/less/start.sh"]
