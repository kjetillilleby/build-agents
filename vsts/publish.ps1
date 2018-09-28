# docker build -t v-develop -f develop.dockerfile .
# docker tag v-develop klilleby/vsts-develop:1.3
# docker tag v-develop klilleby/vsts-develop:latest
#docker push klilleby/vsts-develop:1.3
#docker push klilleby/vsts-develop:latest

# docker build -t v-node -f node.dockerfile .
# docker tag v-node klilleby/vsts:node-10.5
# docker tag v-node klilleby/vsts:latest
# docker push klilleby/vsts:node-10.5
# docker push klilleby/vsts:latest

#docker build -t v-nodejava -f java.dockerfile .
#docker tag v-nodejava klilleby/vsts:scan
docker push  klilleby/vsts:scan

# docker build -t v-gcloud -f gcloud.dockerfile .
# docker tag v-gcloud klilleby/vsts:gcloud-node-9.8
# docker push klilleby/vsts:gcloud-node-9.8
