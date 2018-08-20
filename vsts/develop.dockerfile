FROM microsoft/vsts-agent:ubuntu-16.04

RUN useradd -ms /bin/bash vsts

# install "forgotten" dependencies for ubuntu using the "puppeteer" npm package.
# revisit this list of dependencies for newer versions of the package. puppeteer version 1.0.0 
RUN apt-get update -y && apt-get install -y \
    gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
    libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
    libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
    libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 \
    libnss3 lsb-release xdg-utils wget build-essential libssl-dev\
    && rm -rf /var/lib/apt/lists/*

# install node
ENV NODE_VERSION=v10.5.0
RUN mkdir /nodejs && curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
ENV PATH $PATH:/nodejs/bin

# install npm packages
RUN npm install -g @angular/cli @nrwl/schematics

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.03.1-ce

RUN set -ex \
 && curl -fL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/`uname -m`/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
 && tar --extract --file docker.tgz --strip-components 1 --directory /usr/local/bin \
 && rm docker.tgz \
 && docker -v

ENV DOCKER_COMPOSE_VERSION 1.22.0-rc1

RUN set -x \
 && curl -fSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose \
 && docker-compose -v

# Install Go
ENV GO_VERSION 1.10.3
RUN curl -sL "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" -o go.linux-amd64.tar.gz \
 && mkdir -p /usr/local/go \
 && tar -C /usr/local/go -xzf go.linux-amd64.tar.gz --strip-components=1 go \
 && rm go.linux-amd64.tar.gz
ENV GOROOT=/usr/local/go
ENV PATH $PATH:$GOROOT/bin

## install gcloud with kubectl
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk kubectl -y

## install java 8
ENV JVM_KEYSTORE /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts

RUN apt-get update -y && apt-get install -y \
    default-jre \
    && rm -rf /var/lib/apt/lists/*

## install Helm
ENV HELM_VERSION v2.9.0
RUN curl -sL "https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz" -o helm.linux-amd64.tar.gz \
 && mkdir -p /usr/local/helm \
 && tar -C /usr/local/helm -xzf helm.linux-amd64.tar.gz --strip-components=1 linux-amd64/helm \
 && rm helm.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/helm

## install Istio (istio.io)
ENV ISTIO_VERSION 1.0.0
RUN curl -sL "https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux.tar.gz" -o istio.linux-amd64.tar.gz \
 && mkdir -p /usr/local/istio \
 && tar -C /usr/local/istio -xzf istio.linux-amd64.tar.gz --strip-components=1 "istio-${ISTIO_VERSION}" \
 && rm istio.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/istio/bin


COPY ./start-with-sonar.sh /vsts/