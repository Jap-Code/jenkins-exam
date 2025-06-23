pipeline {
    agent any
    stages {
        stage('deploy cast db') {
            environment {
                RELEASE = 'cast'
            }
            steps {
                script {
                    sh """
                    ./cast-db/deploy.sh
                    helm upgrade --install ${RELEASE} ./charts \
                        -f values.yaml
                        -n ${ENV} \
                        --atmoic
                    """
                }
            }
        }
    }
}