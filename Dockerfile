FROM alpine:latest
LABEL version="v1.5.0" maintainer="Dynatrace ACE team<ace@dynatrace.com>"

ARG MAC_VERSION="v1.5.0"
ENV MONACO_DOWNLOAD_URL=https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/${MAC_VERSION}/monaco-linux-amd64

RUN apk add --update --no-cache \
    curl \
    jq \
    ca-certificates \
    bash \
    nss \
    unzip \
    util-linux \
    wget \
    libc6-compat

RUN mkdir /dynatrace

#Install DT Monitoring as Code - Monaco
RUN curl -sL ${MONACO_DOWNLOAD_URL} -o /usr/bin/monaco
RUN chmod +x /usr/bin/monaco

CMD ["/bin/bash", "-l", "-c"]
ENTRYPOINT ["/bin/bash", "-l", "-c"]