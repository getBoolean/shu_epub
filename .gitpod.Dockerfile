FROM gitpod/workspace-full
SHELL ["/bin/bash", "-c"]

ENV FLUTTER_VERSION=3.3.9-stable
ENV PATH=/usr/lib/dart/bin:$PATH

# Install Dart
USER root
RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list \
    && install-packages build-essential dart libkrb5-dev gcc make
    
# Install flutter
USER gitpod
RUN cd /home/gitpod \
    && wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz \
    && tar -xvf flutter*.tar.xz \
    && rm -f flutter*.tar.xz

RUN flutter/bin/flutter precache
RUN echo 'export PATH="$PATH:/home/gitpod/flutter/bin"' >> /home/gitpod/.bashrc

# Install Google Chrome
USER root
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && sudo apt-get install -y google-chrome-stable

# misc deps
RUN apt-get install -y \
  libasound2-dev \
  libgtk-3-dev \
  libnss3-dev \
  fonts-noto \
  fonts-noto-cjk

# For Qt WebEngine on docker
ENV QTWEBENGINE_DISABLE_SANDBOX 1

# Install PlantUML dependencies
RUN apt-get install -y wget apt-transport-https gnupg
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get install temurin-17-jdk
RUN apt-get install graphviz