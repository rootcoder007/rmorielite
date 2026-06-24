# rmorielite container: the focused carceral/policing/public-health interface.
# rmorie installs from r-universe; if no matching binary it compiles from
# source, so we install the system libs its C++ backend needs (libcurl etc.).
FROM rocker/r-ver:4.4.1
RUN apt-get update && apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev libssl-dev libxml2-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
RUN R -e "options(repos = c(rootcoder007 = 'https://rootcoder007.r-universe.dev', \
          CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
          install.packages(c('rmorie', 'rmoriedata', 'httr2'))"
WORKDIR /pkg
COPY . /pkg
RUN R CMD INSTALL --no-multiarch --with-keep.source /pkg \
    && Rscript -e 'stopifnot(requireNamespace("rmorielite", quietly = TRUE)); cat(length(getNamespaceExports("rmorielite")), "exported functions\n")'
CMD ["R"]
