FROM continuumio/anaconda3:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV CONDA_HOME /opt/conda

RUN \
	$CONDA_HOME/bin/conda update -n base -c defaults conda && \
    $CONDA_HOME/bin/conda install -c conda-forge jupyterhub nb_conda nb_conda_kernels jupyter_contrib_nbextensions && \
	$CONDA_HOME/bin/pip install jupyterhub-firstuseauthenticator && \
	jupyter contrib nbextension install --sys-prefix
	
RUN \
	jupyter labextension install jupyterlab-plotly && \
	jupyter labextension install jupyterlab-dash && \
	$CONDA_HOME/bin/conda install -c conda-forge plotly dash datashader

RUN mkdir -p /srv/jupyterhub/
WORKDIR /srv/jupyterhub/

EXPOSE 8000

CMD ["jupyterhub"]