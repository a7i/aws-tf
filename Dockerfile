FROM hashicorp/terraform:0.12.0-rc1

LABEL author="a7i"

ADD VERSION .
ENV KUBECTL_VERSION 1.14.1
ENV HELM_VERSION 2.12.2

RUN apk add --no-cache \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  bash \
  jq \
  curl \
  && pip --no-cache-dir install awscli==1.16.140 \
  && rm -rf /var/cache/apk/*

# Install kubectl
RUN curl -s -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl

# Install Helm
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
  -o /usr/bin/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
  && tar xvzf /usr/bin/helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /tmp/ \
  && mv /tmp/linux-amd64/helm /usr/bin \
  && chmod +x /usr/bin/helm \
  && helm init --client-only

# Install aws-iam-authenticator
RUN curl -s -L -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x /usr/bin/aws-iam-authenticator