# Setup
FROM quantecon/notebook
LABEL maintainer="QuantEcon Project <admin@quantecon.org>"
ARG PACKAGEVERSION=v0.9.5

# Install unzip for Electron and packages for Cairo
USER root
RUN apt-get update && apt-get install -y --no-install-recommends unzip \
    gettext \
    zlib1g-dev \
    libffi-dev \
    libpng-dev \
    libpixman-1-dev \
    libpoppler-dev \
    librsvg2-dev \
    libcairo2-dev \
    libpango1.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch user back.
USER $NB_UID

# Tagged version of QELAP
RUN julia -e "using InstantiateFromURL; activate_github(\"QuantEcon/QuantEconLectureAllPackages\", tag = \"${PACKAGEVERSION}\")"

# Master QELAP
RUN julia -e "using InstantiateFromURL; activate_github(\"QuantEcon/QuantEconLectureAllPackages\")"
