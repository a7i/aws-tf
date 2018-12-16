FROM hashicorp/terraform:0.11.10

LABEL author="a7i"

ADD VERSION .

RUN apk add --no-cache \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  bash \
  jq \
  && pip --no-cache-dir install awscli==1.16.40 \
  && rm -rf /var/cache/apk/*