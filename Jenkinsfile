pipeline {
    agent any
    stages {
        stage('deploy cast db') {
            environment {
                ENV = 'dev'
                RELEASE = 'cast-db'
                KUBECONFIG = credentials("config")
            }
            steps {
                script {
                    sh """
                    ./cast-db/deploy.sh
                    helm upgrade --install ${RELEASE} ./charts \
                        -f values.yaml \
                        -n ${ENV} \
                        --atomic
                    """
                }
            }
        }
    }
}