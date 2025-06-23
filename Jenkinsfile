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
                    ./cast-db/delpoy.sh
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