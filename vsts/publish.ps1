#docker build -t v-node -f node.dockerfile .
#docker tag v-node klilleby/vsts:node-9.11
docker push klilleby/vsts:node-9.11

# docker build -t v-nodejava -f java.dockerfile .
# docker tag v-nodejava klilleby/vsts:java-node-9.8
# docker push klilleby/vsts:java-node-9.8

# docker build -t v-gcloud -f gcloud.dockerfile .
# docker tag v-gcloud klilleby/vsts:gcloud-node-9.8
# docker push klilleby/vsts:gcloud-node-9.8
