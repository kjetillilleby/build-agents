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
    libnss3 lsb-release xdg-utils wget build-essential libssl-dev python\
    && rm -rf /var/lib/apt/lists/*

# install node
ENV NODE_VERSION=v10.5.0
RUN mkdir /nodejs && curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
ENV PATH $PATH:/nodejs/bin

# install npm packages
RUN npm install -g @angular/cli @nrwl/schematics

