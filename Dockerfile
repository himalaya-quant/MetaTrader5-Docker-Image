FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbullseye-8446af38-ls104

# set version label
ARG BUILD_DATE
ARG VERSION

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
    git \
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

# Install puppeteer required deps
RUN apt-get install -y \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
    wget \
    xdg-utils

COPY /Metatrader /Metatrader

RUN sudo chown -R abc: /Metatrader
RUN chmod +x /Metatrader/start.sh
RUN chmod +x /Metatrader/init-config.sh
RUN chmod +x /Metatrader/mt5-auto-login.sh

COPY /root /

EXPOSE 3000 8001
VOLUME /config
