FROM klilleby/vsts:node-9.8

ENV JVM_KEYSTORE /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts

RUN apt-get update -y && apt-get install -y \
    default-jre \
    && rm -rf /var/lib/apt/lists/*

COPY ./start-with-sonar.sh /vsts/
