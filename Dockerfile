# We build this image atop of the anaconda distribution with python 3.6.
FROM continuumio/anaconda3
LABEL maintainer = "Irfan Sharif <irfanmahmoudsharif@gmail.com>"

# Additionally install latest available version of tensorflow.
RUN conda install --quiet --yes 'tensorflow=1.6' \
    && conda clean -y \
      --tarballs \
      --index-cache \
      --packages \
      --source-cache

# We package in all the notebooks into the image itself. Datasets
# (notebooks/datasets) ignore.
#
# NB: This image can be mounted off a local directory, doing so persists
# the changes made to /notebooks via Jupyter on to the host filesystem.
COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We copy over our wrapper script that sets up a server over /notebooks.
COPY run-jupyter /bin/run-jupyter

# Jupyter, by default, listens in on port 8888.
EXPOSE 8888

CMD ["/bin/run-jupyter", "--allow-root"]
