# Using the monaco-runner in a JFrog environment

This example assumes that the monaco files reside in a GitHub repo within a subfolder called `monaco`.  In addition, the two JFrog Pipeline integrations are setup for the repo and Dynatrace API credentials.

## JFrog Pipeline integrations

[Integrations](https://www.jfrog.com/confluence/display/JFROG/Pipelines+Integrations) connect Pipelines to an external service/tool. Each integration type defines the endpoint, credentials and any other configuration detail required for Pipelines to exchange information with the service.  Below are the integrations used in this reference example, but you can adjust names for your needs:

| Name | Type | Comment |
| ------- | ----------- | ------- |
| dynatraceIntegration | Generic | Need to store two key pairs: DT_BASEURL and DT_API_TOKEN. |
| githubIntegration | GitHub | Stores the GitHub URL and User Access Token the GitHub account where the pipeline code is stored. The GitHub user must have admin rights for the Pipelines repository. |

## Example Pipeline

```
resources:
  - name: gitRepo   
    type: GitRepo
    configuration:
      gitProvider: githubIntegration              
      path: dt-demos/jfrog-pipelines-dynatrace-example  # <-- replace with your github username or org name and repo name
      branches:
        include: main                                   # <-- adjust to your branch name
      buildOn:
        commit: true
 pipelines:
  - name: dynatraceDemo
    steps:
      - name: ConfigureDynatrace
        type: Bash
        configuration:
          affinityGroup: Configuration
          runtime:
            type: host
          inputResources:
            - name: gitRepo
          integrations:
            - name: dynatraceIntegration
        execution:
          onExecute:
            - DT_BASEURL=${int_dynatraceIntegration_DT_URL}
            - DT_API_TOKEN=${int_dynatraceIntegration_DT_API_TOKEN}
            - docker run -e DT_BASEURL=$DT_BASEURL -e DT_API_TOKEN=$DT_API_TOKEN -e NEW_CLI=1 -v $res_gitRepo_resourcePath:/monaco-mount/ dynatraceace/monaco-runner:release-v1.6.0 "monaco deploy -v --environments /monaco-mount/monaco/environments.yml --project demoapp /monaco-mount/monaco/projects"

```