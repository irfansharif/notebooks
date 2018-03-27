FROM continuumio/anaconda3
LABEL maintainer = "Irfan Sharif <irfanmahmoudsharif@gmail.com>"

COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We copy over our wrapper script.
COPY run-jupyter /bin/run-jupyter

# Jupyter, be default, listens in on port 8888.
EXPOSE 8888

CMD ["/bin/run-jupyter", "--allow-root"]
