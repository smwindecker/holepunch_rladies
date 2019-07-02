FROM rocker/binder:3.6.0
LABEL maintainer='Saras Windecker'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
RUN wget https://github.com/smwindecker/holepunch_rladies/raw/master/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2019-07-02/')); devtools::install_deps()"
