FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbullseye-8446af38-ls104

# set version label
ARG BUILD_DATE
ARG VERSION

# args for initial_config.ini file for MT5
ARG MT5_LOGIN
ARG MT5_PASSWORD
ARG MT5_SERVER

LABEL build_version="Metatrader Docker:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Caius Citiriga"

ENV TITLE="Himalaya MT5"
ENV WINEPREFIX="/config/.wine"

# Update package lists and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
    python3-pip \
    wget \
    && pip3 install --upgrade pip

# Add WineHQ repository key and APT source
RUN wget -q https://dl.winehq.org/wine-builds/winehq.key \
    && apt-key add winehq.key \
    && add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' \
    && rm winehq.key

# Add i386 architecture and update package lists
RUN dpkg --add-architecture i386 \
    && apt-get update

# Install WineHQ stable package and dependencies
RUN apt-get install --install-recommends -y \
    winehq-stable \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY /Metatrader /Metatrader

# Write the default initial config file
RUN touch /Metatrader/initial_config.ini && \
    echo "[Common]" >> /Metatrader/initial_config.ini && \
    echo "Login=${MT5_LOGIN}" >> /Metatrader/initial_config.ini && \
    echo 'Password=${MT5_PASSWORD}' >> /Metatrader/initial_config.ini && \
    echo 'Server=${MT5_SERVER}' >> /Metatrader/initial_config.ini && \

RUN chmod +x /Metatrader/start.sh
COPY /root /

EXPOSE 3000 8001
VOLUME /config
