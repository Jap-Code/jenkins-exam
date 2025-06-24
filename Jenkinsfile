pipeline {
    environment {
        DOCKER_ID = "jan986"
        DOCKER_TAG = "v.0.${BUILD_ID}"
        DOCKER_PASS = credentials("DOCKER_HUB_PASS")
        KUBECONFIG = credentials("config")
    }
    agent any
    stages {
        stage('Image Build') {
            parallel {
                stage('Docker Build Movie') {
                    steps {
                        script {
                            sh '''
                            docker build -t $DOCKER_ID/movie:$DOCKER_TAG ./movie-service
                            '''
                        }
                    }
                }
                stage('Docker Build Cast') {
                    steps {
                        script {
                            sh '''
                            docker build -t $DOCKER_ID/cast:$DOCKER_TAG ./cast-service
                            '''
                        }
                    }
                }
                stage('Docker Build Nginx') {
                    steps {
                        script {
                            sh '''
                            docker build -t $DOCKER_ID/nginx:$DOCKER_TAG ./nginx
                            '''
                        }
                    }
                }
            }
        }
        stage('Image Push') {
            parallel {
                stage('Docker Push Movie') {
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_PASS
                            docker push $DOCKER_ID/movie:$DOCKER_TAG
                            '''
                        }
                    }
                }
                stage('Docker Push Cast') {
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_PASS
                            docker push $DOCKER_ID/cast:$DOCKER_TAG 
                            '''
                        }
                    }
                }
                stage('Docker Push Nginx') {
                    steps {
                        script {
                            sh '''
                            docker login -u $DOCKER_ID -p $DOCKER_PASS
                            docker push $DOCKER_ID/nginx:$DOCKER_TAG 
                            '''
                        }
                    }
                }
            }
        }
        stage('deploy-db:dev') {
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
            }
        }
        stage('deploy-app:dev') {
            environment {
                ENV = 'dev'
            }
            parallel {
                stage('deploy cast-app') {
                    environment {
                        RELEASE = 'cast'
                    }
                    steps {
                        script {
                            sh """
                            ./cast-service/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy movie-app') {
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
                stage('deploy-nginx') {
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
        stage('deploy-db:qa') {
            environment {
                ENV = 'qa'
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
            }
        }
        stage('deploy-app:qa') {
            environment {
                ENV = 'qa'
            }
            parallel {
                stage('deploy cast-app') {
                    environment {
                        RELEASE = 'cast'
                    }
                    steps {
                        script {
                            sh """
                            ./cast-service/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy movie-app') {
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
                stage('deploy-nginx') {
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
        stage('deploy-db:staging') {
            environment {
                ENV = 'staging'
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
            }
        }
        stage('deploy-app:staging') {
            environment {
                ENV = 'staging'
            }
            parallel {
                stage('deploy cast-app') {
                    environment {
                        RELEASE = 'cast'
                    }
                    steps {
                        script {
                            sh """
                            ./cast-service/deploy.sh
                            helm upgrade --install ${RELEASE} ./charts \
                                -f values.yaml \
                                -n ${ENV} \
                                --atomic
                            """
                        }
                    }
                }
                stage('deploy movie-app') {
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
        stage('deploy db:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            parallel {
                stage('deploy cast-db:prod') {
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
                stage('deploy movie-db:prod') {
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
            }
        }
        stage('deploy cast-app:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            stage('deploy cast app') {
                environment {
                    RELEASE = 'cast'
                }
                steps {
                    timeount(time: 15, unit: "MINUTES") {
                        input message: 'Do you want to deploy in production?', ok: 'Yes!'
                    }
                    script {
                        sh """
                        ./cast-service/deploy.sh
                        helm upgrade --install ${RELEASE} ./charts \
                            -f values.yaml \
                            -n ${ENV} \
                            --atomic
                        """
                    }
                }
            }
        }
        stage('deploy movie-app:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            stage('deploy movie-app:prod') {
                environment {
                    RELEASE = 'movie'
                }
                steps {
                    timeount(time: 15, unit: "MINUTES") {
                        input message: 'Do you want to deploy in production?', ok: 'Yes!'
                    }
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
        }
        stage('deploy nginx:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            stage('deploy nginx:prod') {
                environment {
                    RELEASE = 'nginx'
                }
                steps {
                    timeount(time: 15, unit: "MINUTES") {
                        input message: 'Do you want to deploy in production?', ok: 'Yes!'
                    }
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