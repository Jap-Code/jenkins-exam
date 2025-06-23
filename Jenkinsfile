pipeline {
    agent any
    stages {
        stage('deploy cast db') {
            environment {
                SERVICE = 'cast'
            }
            steps {
                script {
                    sh '''
                    ./cast-db/delpoy.sh
                    helm upgrade --install $SERVICE ./charts \
                        -f values.yaml
                        -n $ENV \
                        --atmoic
                    '''
                }
            }
        }
    }
}