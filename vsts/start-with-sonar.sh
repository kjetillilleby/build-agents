#!/bin/bash

#add certificates to java keystore
keytool -importcert -file /usr/local/share/ca-certificates/sonarqube-test.cer -keystore $JVM_KEYSTORE -alias "SonarQube Test" -storepass changeit -noprompt
keytool -importcert -file /usr/local/share/ca-certificates/sonarqube-dev.cer -keystore $JVM_KEYSTORE -alias "SonarQube Dev" -storepass changeit -noprompt

#start agent
./start.sh
