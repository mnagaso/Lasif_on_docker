FROM ubuntu:19.04

# one can put the label of maintainer of this dockerfile.
LABEL maintainer="Masaru Nagaso <mnsaru22@gmail.com>"

## Part 1: Base Image and Run Dependencies

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update					     &&\
    apt-get install -y					   \
                python \
                python-pip \
                python-setuptools \
                build-essential \
                git \
                nodejs npm \
                wget \
                openmpi-bin
                #openmpi-common \
                #openssh-client \
                #openssh-server \
                #libopenmpi1.3 \
                #libopenmpi-dbg \
                #libopenmpi-dev


# dependeicies  
RUN pip install \
    numpy \
    jupyterlab \
    numexpr \
    matplotlib  
# install obspy in the separate step from numpy is required
RUN pip install \
    obspy \
    https://github.com/krischer/wfs_input_generator/archive/master.zip \
    geographiclib \
    progressbar \
    colorama \
    mpi4py \
    joblib \
    flask flask-cache geojson \
    pytest mock nose flake8

# install basemap
RUN pip install \
    pyproj==1.9.6 \
    Pillow \
    && wget https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz \
    && tar -zxvf v1.1.0.tar.gz \
    && cd basemap-1.1.0/geos-3.3.3 \
    && export GEOS_DIR=/usr/local \
    && export CXX="g++ -std=c++98" \
    && ./configure --prefix=$GEOS_DIR \
    && make \
    && make install \
    && cd .. \
    && python setup.py install

# install pyqt and pyqt graph
RUN apt-get update \
    && apt-get install -y \
        python-qt4 \
        python-backports.functools-lru-cache \
        python-tk \
    && pip install \
        pyqtgraph \
        flask-caching

# install LASIF
RUN cd / \
   && git clone https://github.com/krischer/LASIF.git \
   && cd LASIF \
   && pip install -v -e .
# patching the old import way of flask-cache
RUN sed -i 's/flask.ext.cache/flask_caching/g' /LASIF/lasif/webinterface/server.py


WORKDIR /workspace

# vim option on jupyterlab
#RUN npm install npm@latest -g \
# && npm config set user 0 \
# && npm config set unsafe-perm true \
# && npm install ijavascript -g
#
#RUN ijsinstall --hide-undefined --install=global
#RUN jupyter labextension install jupyterlab_vim
#RUN apt install -y git
#RUN pip3 install jupyter_contrib_nbextensions \
#  && jupyter contrib nbextension install --user \
#  && mkdir -p $(jupyter --data-dir)/nbextensions \
#  && cd $(jupyter --data-dir)/nbextensions \
#  && git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding \
#  && jupyter nbextension enable vim_binding/vim_binding 

