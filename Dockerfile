FROM rocker/tidyverse:4

RUN apt-get -q update && \
    apt-get -y install --no-install-recommends libxt6 && \
    rm -rf rm -rf /var/lib/apt/lists/*

COPY DESCRIPTION /src/statusboard/
RUN  Rscript -e "devtools::install_deps('/src/statusboard', upgrade=FALSE)"

COPY . /src/statusboard/
RUN Rscript -e "devtools::install('/src/statusboard', upgrade=FALSE)"

ENV DATA_URL="https://raw.githubusercontent.com/PecanProject/pecan-status-board/main/"

EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');statusboard::run_app()"
