FROM ghcr.io/foosa/r-devtools:main

# Name of the project
ARG PROJECT_NAME=r-nextflow-template

# Name of the R package (defined in DESCRIPTION)
ARG R_PACKAGE_NAME=NextflowTemplate

# Name of the R script
ARG R_SCRIPT_NAME=hello


# Copy the R sourcecode and install locally
COPY . /opt/src/$PROJECT_NAME
RUN Rscript -e "\
  library(devtools); \
  devtools::install_local(\"/opt/src/$PROJECT_NAME\"); \
  "

# Symbolic link the script to /usr/local/bin
RUN ln -s /usr/local/lib/R/site-library/$R_PACKAGE_NAME/bin/$R_SCRIPT_NAME \
  /usr/local/bin/$R_SCRIPT_NAME

