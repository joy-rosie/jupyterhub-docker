FROM continuumio/anaconda3:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV CONDA_HOME /opt/conda
ENV NB_USER jupyterhub

RUN echo export PATH=$CONDA_HOME/bin:'$PATH' > /etc/profile.d/conda.sh

RUN apt-get update \
	&& apt-get install -yq --no-install-recommends \
		libgtk2.0-dev \
		build-essential \
		ca-certificates \
		locales \
		wget \
		bzip2 \
		libglib2.0-0 \
		libxext6 \ 
		libsm6 \ 
		libxrender1 \ 
		openssl \
		git \
		g++ \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
	
RUN \
    useradd -ms /bin/bash $NB_USER && \
    echo jupyterhub:password | chpasswd

RUN $CONDA_HOME/bin/conda update -n base -c defaults conda && \
    $CONDA_HOME/bin/conda install -c conda-forge jupyterhub nb_conda nb_conda_kernels jupyter_contrib_nbextensions && \
	$CONDA_HOME/bin/pip install jupyterhub-firstuseauthenticator && \
	jupyter contrib nbextension install --sys-prefix && \
	jupyter labextension install jupyterlab-plotly && \
	jupyter labextension install jupyterlab-dash && \
	$CONDA_HOME/bin/conda install -c conda-forge plotly dash datashader

RUN mkdir -p /srv/jupyterhub/
WORKDIR /srv/jupyterhub/

EXPOSE 8000

CMD ["jupyterhub"]