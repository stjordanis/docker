FROM google/cloud-sdk
MAINTAINER arnav.sood@ubc.ca

ADD setup.sh setup.sh
RUN chmod +x setup.sh
ADD config.yaml config.yaml
RUN apt-get update && apt-get install nano
