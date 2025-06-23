pipeline {
    environment {
        DOCKER_ID = "jan986"
        DOCKER_TAG = "v.0.${BUILD_ID}.0"
        DOCKER_PASS = credentials("DOCKER_HUB_PASS")
        KUBECONFIG = credentials("config")
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
                            docker build -t $DOCKER_ID/movie-service:$DOCKER_TAG ./cast-service
                            '''
                        }
                    }
                }
                stage('Docker Build Movie Service') {
                    steps {
                        script {
                            sh '''
                            docker build -t $DOCKER_ID/cast-service:$DOCKER_TAG ./movie-service
                            '''
                        }
                    }
                }
            }
        }
        stage('Image Push') {
            parallel {
                stage('Docker Push Cast Service') {
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
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_PASS
                            docker push $DOCKER_ID/cast-service:$DOCKER_TAG 
                            '''
                        }
                    }
                }
            }
        }
        stage('deploy:dev') {
            environment {
                ENV = 'dev'
            }
            parallel {
                stage('deploy cast-db') {
                    environment {
                        RELEASE = 'cast-db'
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
                stage('deploy movie-db') {
                    environment {
                        RELEASE = 'movie-db'
                    }
                    steps {
                        script {
                            sh """
                            ./movie-db/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy movie-service') {
                    environment {
                        RELEASE = 'movie'
                    }
                    steps {
                        script {
                            sh """
                            ./movie-service/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy cast-service') {
                    environment {
                        RELEASE = 'cast'
                    }
                    steps {
                        script {
                            sh """
                            .cast-service/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy nginx') {
                    environment {
                        RELEASE = 'nginx'
                    }
                    steps {
                        script {
                            sh """
                            ./nginx/deploy.sh
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
    }
}
