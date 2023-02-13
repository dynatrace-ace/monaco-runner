# Using the monaco-runner in a GitHub environment

1. Add these GitHub secrets
    * DT_BASE_URL
    * DT_API_TOKEN

1. This example assumes monaco project files are in the GitHub root folder `monaco`

1. In your pipeline `yml` file you can now refer to the runner like this:
    ```
    name: Dynatrace Monitoring as Code
    on:
    workflow_dispatch:
    jobs:
    build:
      runs-on: ubuntu-latest
      container:
        image: dynatraceace/monaco-runner:release-v1.6.0
        env:
          DT_BASEURL: ${{ secrets.DT_BASE_URL }}
          DT_API_TOKEN: ${{ secrets.DT_API_TOKEN }}
          NEW_CLI: "1"
        steps:
        # github automatically creates a volume to the checked out code
        # so we can reference them via ./foldername
        - uses: actions/checkout@v2

        - name: Monaco version
          run: monaco --version

        - name: Run Monaco
          run:  monaco deploy -v --environments ./monaco/environments.yml --project dt-orders ./monaco/projects
    ```
