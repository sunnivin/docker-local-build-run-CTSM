# --------------------------------------------------------------------------------------------
# CTSM host land model with experimental FATES land component docker container on GCC-base OS
# --------------------------------------------------------------------------------------------

FROM ngeetropics/hlmbase-gcc650:v.0.0.0
LABEL maintainer.name="Sunniva Indrehus" \
      maintainer.email="sunniva.indrehus@gmail.com" \
      author.name="Sunniva Indrehus" \
      author.email="sunniva.indrehus@gmail.com" \
      author.name="Sunniva Indrehus" \
      description="CTSM host land model on GCC-base OS" \
      version.fates="sci.1.43.2_api.14.2.0" \
      version.hlm="ctsm5.1.dev022" \
      version.baseos="gcc6.5"

# setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

# Setup environment variables.  This is necessary for os.environ calls from case.py in CIME
ENV USER=fatesuser

# Add user directory structure.  This is necessary for CIME
RUN useradd -m $USER -u 9001

## create data mount points in container - should change this to /mnt or something more generic in machines files
RUN mkdir -p inputdata \
    && mkdir -p output \
    && mkdir -p scripts \
    && mkdir -p baselines \
    && mkdir -p .cime \
    && mkdir -p CTSM  

# ## Set local path to the code folder of CTSM
# ENV CTSM_PATH /home/sunnivin/Documents/UiO/code/ESCMOP/ctsm-ozone-luna/CTSM
# RUN echo $CTSM_PATH ${CTSM_PATH}
 
# ### Copy in the local version of CTSM
# ADD /home/sunnivin/Documents/UiO/code/ESCMOP/ctsm-ozone-luna/CTSM /CTSM/   

# ## Do manage externals to get the different model components
# RUN cd CTSM \
#     && ./manage_externals/checkout_externals \
#     && git branch

## Set-up the docker-specific configurations for the machine config files. 
RUN cd /.cime \
    && wget https://raw.githubusercontent.com/NGEET/docker-fates-tutorial/master/docker/ctsm/cime_config/config \ 
    && wget https://raw.githubusercontent.com/NGEET/docker-fates-tutorial/master/docker/ctsm/cime_config/config_compilers.xml \
    && wget https://raw.githubusercontent.com/NGEET/docker-fates-tutorial/master/docker/ctsm/cime_config/config_machines.xml

## EOF