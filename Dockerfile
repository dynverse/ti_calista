FROM dynverse/dynwrapr:v0.1.0

# Patch was generated by making changes in the calista git repository,
# and then running:
# git diff --no-prefix > calista.patch

RUN apt-get update && apt-get install -y libcgal-dev libglu1-mesa-dev libglu1-mesa-dev libjpeg-dev libtiff-dev tcl-dev patch

RUN cd / && \
    git clone https://github.com/CABSEL/CALISTA.git && \
    cd CALISTA && \
    git checkout 367d5bdbfa80796145a9feba0f1dffb144ac67bc && \
    rm -rf .git && \
    find . -type f \( -iname \*.zip -o -iname \*.csv -o -iname \*.txt \) -exec rm {} + && \
    wget https://gist.githubusercontent.com/rcannood/ed97cacc2f373de6f3a6bb7320e2c677/raw/935044855cd204aee6eba821367b95669bb14784/calista.patch && \
    patch -p0 < calista.patch

RUN Rscript /CALISTA/CALISTA-R/install_packs.R && \
    rm -rf /tmp/*

COPY definition.yml run.R example.sh /code/

ENTRYPOINT ["/code/run.R"]
