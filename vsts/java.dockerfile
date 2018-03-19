FROM klilleby/vsts:node-9.8

RUN apt-get update -y && apt-get install -y \
    default-jre \
    && rm -rf /var/lib/apt/lists/*