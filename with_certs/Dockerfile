FROM dynatraceace/monaco-runner:release-v1.1.0 
LABEL version="1.0" maintainer="Dynatrace ACE team<ace@dynatrace.com>"

RUN apk --no-cache add ca-certificates

ADD ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bin/bash", "-l", "-c"]
