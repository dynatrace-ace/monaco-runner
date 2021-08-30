# Overview

Automation is the key to successful IT operations. Automation is also the key to successful monitoring and how you set up your monitoring environment or software intelligence platform.

Without such rules, configuring your environments can result in chaos, with losses in flexibility, speed, and stability.  One option to automate Dynatrace monitoring configurations to one or multiple Dynatrace environments is the [Monaco (Monitoring as Code)](https://dynatrace-oss.github.io/dynatrace-monitoring-as-code/) toolset. 

To automate `Monaco` within pipelines, this repo creates a container image with the Dynatrace's Monaco that be be used within any CI/CD any pipeline that supports running a Docker image with a volume mount.

## Example Usage

* [GitHub Actions](GITHUB.MD)
* [Jenkins](JENKINS.MD)
* [JFrog Pipelines](JFROG.MD)

## Development

1. Create or adjust the various configuration files according the [monaco configuration structure](https://dynatrace-oss.github.io/dynatrace-monitoring-as-code/configuration/yaml_confg)

1. Set the Dynatrace URL and API Token and local variables

    ```
    export DT_BASEURL=[YOUR URL]
    export DT_API_TOKEN=[YOUR API TOKEN]
    ```

1. Run Docker image with a volume mount (assuming monaco files are in current directory)

```
docker run -e DT_BASEURL=$DT_BASEURL -e DT_API_TOKEN=$DT_API_TOKEN -e NEW_CLI=1 -v $(pwd):/monaco-mount/ dynatraceace/monaco-runner:release-v1.6.0 "monaco deploy -v --environments /monaco-mount/monaco/environments.yml --project demoapp /monaco-mount/monaco/projects"
```

## Dealing with untrusted certificates

In cases where you need to use Monaco against a Dynatrace environment with untrusted certificates, you can use this image as a base for creating a custom Docker image. An example for that is in [with_certs/Dockerfile](with_certs/Dockerfile)
```
FROM dynatraceace/monaco-runner:release-v1.6.0 
LABEL version="1.0" maintainer="Dynatrace ACE team<ace@dynatrace.com>"

RUN apk --no-cache add ca-certificates

ADD ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/bin/bash", "-l", "-c"]
```