From alpine:3.11

ARG KUBECTL_VERSION=v1.19.12
ARG TARGETPLATFORM

RUN apk update && apk add \
   bash \
   bash-completion \
   busybox-extras \
   net-tools \
   vim \
   curl \
   wget \
   tcpdump \
   ca-certificates && \
   update-ca-certificates && \
   rm -rf /var/cache/apk/* && \
   curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl && \
   chmod +x ./kubectl && \
   mv ./kubectl /usr/local/bin/kubectl && \
   echo -e 'source /usr/share/bash-completion/bash_completion\nsource <(kubectl completion bash)' >>~/.bashrc


From alpine:3.11

COPY --from=0 /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]


