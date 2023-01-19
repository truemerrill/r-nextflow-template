FROM r-base:latest
MAINTAINER True Merrill true.merrill@gtri.gatech.edu


# Install libraries required to build R packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libtiff5-dev \
    libxml2-dev \
  && rm -rf /var/lib/apt/lists/*


# Install development packages for R
RUN Rscript -e "install.packages(c( \
    'covr', \
    'devtools', \
    'DT', \
    'knitr', \
    'lintr', \
    'roxygen2', \
    'testthat' \
  ))"

