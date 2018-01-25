FROM conda/miniconda3

MAINTAINER Thanh Le Viet <lethanhx2k@gmail.com>

RUN apt-get -y update \
    && apt-get install -y gcc g++ git libeigen3-dev

RUN pip install biopython

RUN cd /opt/ \
    && git clone https://github.com/xavierdidelot/ClonalFrameML \
    && cd ClonalFrameML/src \
    && ./make.sh

#Install iqtree from bioconda
RUN conda config --add channels bioconda \
    && conda config --add channels conda-forge \
    && conda config --add channels r \
    && conda install iqtree

# Install iqtree from source
# RUN apt-get install -y cmake \
#    && cd /opt/ \
#    && git clone https://github.com/Cibiv/IQ-TREE.git \
#    && cd IQ-TREE \
#    && mkdir build \
#    && cd build \
#    && cmake \
#    && cmake -DIQTREE_FLAGS=omp .. \
#    && make \
#    && make -j4

ENV PATH /opt/ClonalFrameML/src:$PATH

CMD ["/bin/bash"]
