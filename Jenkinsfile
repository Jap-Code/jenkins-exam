pipeline {
    environment {
        DOCKER_ID = "jan986"
        DOCKER_TAG = "v.1.${BUILD_ID}"
    }
    agent any
    stages {
        stage('Docker Build Cast Service') {
            steps {
                script {
                    sh '''
                    docker rm -f jenkins
                    docker build -t $DOCKER_ID/cast_service:$DOCKER_TAG ./cast-service
                    '''
                }
            }
        }
        stage('Docker Build Movie Service') {
            steps {
                script {
                    sh '''
                    docker build -t $DOCKER_ID/movie_service:$DOCKER_TAG ./movie-service
                    '''
                }
            }
        }
        stage('Docker Push Cast Service') {
            environment {
                DOCKER_PASS = credentials("DOCKER_HUB_PASS")
            }
            steps {
                script {
                    sh '''
                    docker login -u $DOCKER_ID -p $DOCKER_PASS
                    docker push $DOCKER_ID/movie-service:$DOCKER_TAG
                    '''
                }
            }
        }
        stage('Docker Push Movie Service') {
            environment {
                DOCKER_PASS = credentials("DOCKER_HUB_PASS")
            }
            steps {
                script {
                    sh '''
                    docker login -u $DOCKER_ID -p $DOCKER_PASS
                    docker push $DOCKER_ID/cast_service:$DOCKER_TAG 
                    '''
                }
            }
        }
    }
}



    