pipeline {
    environment {
        DOCKER_ID = "jan986"
        // DOCKER_IMAGE = "jenkins-ex"
        DOCKER_TAG = "v.${BUILD_ID}.0"
    }
    agent any
    stages {
        stage('Image Build') {
            parallel {
                stage('Docker Build Cast Service') {
                    steps {
                        script {
                            sh '''
                            docker rm -f jenkins
                            docker build -t cast_service:$DOCKER_TAG ./cast-service
                            '''
                        }
                    }
                }
                stage('Docker Build Movie Service') {
                    steps {
                        script {
                            sh '''
                            docker build -t movie_service:$DOCKER_TAG ./movie-service
                            '''
                        }
                    }
                }
            }
        }
        stage('Image Push') {
            environment {
                DOCKER_PASS = credentials("DOCKER_HUB_PASS")
            }
            parallel {
                stage('Docker Push Cast Service') {
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_PASS
                            docker push docker.io/$DOCKER_ID/movie-service:$DOCKER_TAG
                            '''
                        }
                    }
                }
                stage('Docker Push Movie Service') {
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_HUB_PASS
                            docker push docker.io/$DOCKER_ID/cast_service:$DOCKER_TAG 
                            '''
                        }
                    }
                }
            }
        }
    }
}



    