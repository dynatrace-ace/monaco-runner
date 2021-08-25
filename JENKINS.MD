# Using the monaco-runner in a Jenkins environment with Kubernetes integration

1. Go to `Manage Jenkins` and click on `Configure System`
![](resources/manage_jenkins.png)

1. At the bottom of the page, click on the link directing you to cloud configuration
![](resources/configure_clouds.png)

1. On the Cloud Configuration page, click on `Pod Templates...`
![](resources/configure_clouds_2.png)

1. Add a new pod template and fill it in as follows:
   1. `Name`: A free name for you to give to the template
   2. `Labels`: A label we will use to refer to this template, `monaco-runner` will be used in a later pipeline
   3. `Container template name`: the name of this container, `monaco` will be used in a later pipeline
   4. `Docker Image`: `dynatraceace/monaco-runner:release-v1.6.0` *Note* a new release might be available
   5. `Command to run`: `/bin/sh -c`
   6. `Arguments to pass to the command`: `cat`
   7. `Allocate pseudo-TTY`: `yes`
![](resources/pod_template.png)

1. Click on Save

1. In your `Jenkinsfile` you can now refer to the runner like this:
    ```
    pipeline {
        agent {
            label 'monaco-runner'
        }
        stages {
            stage('Dynatrace global config - Deploy') {
                steps {
                    container('monaco') {
                        script{
                            sh "monaco -v -e=$ENVS_FILE -p=global monaco/projects"
                        }
                    }
                }
            }   
        }
    }
    ```