FROM ghcr.io/foosa/r-devtools:main

ARG PROJECT_NAME=r-nextflow-template
ARG LIBRARY_NAME=rnextflowtemplate

# Copy the R sourcecode and install locally
COPY . /opt/src/$PROJECT_NAME
RUN Rscript -e "\
  library(devtools) \
  devtools::install_local(\"/opt/src/$PROJECT_NAME\")
  "

# Ammend the PATH so that the executable is available to the interpreter.  If your project
# doesn't have a script in inst/bin go ahead and remove this part.
ENV PATH="$PATH:/usr/local/lib/R/site-library/$LIBRARY_NAME/bin"
