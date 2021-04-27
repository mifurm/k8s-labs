FROM alpine
RUN apk update && apk add curl && curl -L -O https://dl.k8s.io/v1.18.0/kubernetes-client-linux-amd64.tar.gz && tar zvxf kubernetes-client-linux-amd64.tar.gz kubernetes/client/bin/kubectl && mv kubernetes/client/bin/kubectl / && rm -rf kubernetes && rm -f kubernetes-client-linux-amd64.tar.gz
ADD proxy.sh /proxy.sh
RUN chmod +x /proxy.sh
ENTRYPOINT /proxy.sh