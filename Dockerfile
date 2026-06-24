# rmorielite container: the focused carceral/policing/public-health interface.
# rmorie + rmoriedata install as Linux binaries from r-universe (fast, no compile).
FROM rocker/r-ver:4.4.1
RUN R -e "options(repos = c(rootcoder007 = 'https://rootcoder007.r-universe.dev', \
          CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
          install.packages(c('rmorie', 'rmoriedata', 'httr2'))"
WORKDIR /pkg
COPY . /pkg
RUN R CMD INSTALL --no-multiarch --with-keep.source /pkg \
    && Rscript -e 'stopifnot(requireNamespace("rmorielite", quietly = TRUE)); cat(length(getNamespaceExports("rmorielite")), "exported functions\n")'
CMD ["R"]
