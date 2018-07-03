#docker build -t v-develop -f develop.dockerfile .
docker tag v-develop klilleby/vsts-develop
docker push klilleby/vsts-develop

# docker build -t v-nodejava -f java.dockerfile .
# docker tag v-nodejava klilleby/vsts:java-node-9.8
# docker push klilleby/vsts:java-node-9.8

# docker build -t v-gcloud -f gcloud.dockerfile .
# docker tag v-gcloud klilleby/vsts:gcloud-node-9.8
# docker push klilleby/vsts:gcloud-node-9.8
