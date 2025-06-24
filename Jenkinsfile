
def Deploy = { RELEASE, PATH ->
    sh """
    ./${PATH}/deploy.sh
    helm upgrade --install ${RELEASE} ./charts \
        -f values.yaml \
        -n ${ENV} \
        --atomic
    """
}

pipeline {
    environment {
        DOCKER_ID = "jan986"
        DOCKER_TAG = "v1" //"v.0.${BUILD_ID}"
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
                    steps {
                        script {
                            Deploy('cast-db', 'cast-db')
                        }
                    }
                }
                stage('deploy movie-db') {
                    steps {
                        script {
                            Deploy('movie-db', 'movie-db')
                        }
                    }
                }
            }
        }
        stage('Wait for Database') {
            steps {
                echo "Waiting for database to be ready..."

                script {
                    // Versucht max. 30 mal, alle 5 Sekunden eine Verbindung zu prüfen
                    def retries = 30
                    def success = false

                    for (int i = 0; i < retries; i++) {
                        def result = sh(
                            script: 'kubectl exec -n dev cast-db-0 -- pg_isready -U admin',
                            returnStatus: true
                        )
                        if (result == 0) {
                            echo "Database is ready!"
                            success = true
                            break
                        } else {
                            echo "Database not ready yet. Waiting 5 seconds..."
                            sleep 5
                        }
                    }

                    if (!success) {
                        error("Database did not become ready in time!")
                    }
                }
            }
        }
        stage('deploy-app:dev') {
            environment {
                ENV = 'dev'
            }
            parallel {
                stage('deploy cast app') {
                    steps {
                        script {
                            Deploy('cast', 'cast-service')
                        }
                    }
                }
                stage('deploy movie app') {
                    steps {
                        script {
                            Deploy('movie', 'movie-service')
                        }
                    }
                }
                stage('deploy-nginx') {
                    steps {
                        script {
                            Deploy('nginx', 'nginx')
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
                    steps {
                        script {
                            Deploy('cast-db', 'cast-db')
                        }
                    }
                }
                stage('deploy movie-db') {
                    steps {
                        script {
                            Deploy('movie-db', 'movie-db')
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
                stage('deploy cast app') {
                    steps {
                        script {
                            Deploy('cast', 'cast-service')
                        }
                    }
                }
                stage('deploy movie app') {
                    steps {
                        script {
                            Deploy('movie', 'movie-service')
                        }
                    }
                }
                stage('deploy-nginx') {
                    steps {
                        script {
                            Deploy('nginx', 'nginx')
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
                    steps {
                        script {
                            Deploy('cast-db', 'cast-db')
                        }
                    }
                }
                stage('deploy movie-db') {
                    steps {
                        script {
                            Deploy('movie-db', 'movie-db')
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
                stage('deploy cast app') {
                    steps {
                        script {
                            Deploy('cast', 'cast-service')
                        }
                    }
                }
                stage('deploy movie app') {
                    steps {
                        script {
                            Deploy('movie', 'movie-service')
                        }
                    }
                }
                stage('deploy-nginx') {
                    steps {
                        script {
                            Deploy('nginx', 'nginx')
                        }
                    }
                }
            }
        }
        stage('deploy-db:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            options {
                timeout(time: 15, unit: "MINUTES") 
                }
            parallel {
                stage('deploy cast-db') {
                    steps {
                        input message: 'Do you want to deploy in production?', ok: 'Yes!'
                        script {
                            Deploy('cast-db', 'cast-db')
                        }
                    }
                }
                stage('deploy movie-db') {
                    steps {
                        script {
                            Deploy('movie-db', 'movie-db')
                        }
                    }
                }
            }
        }
        stage('deploy-app:prod') {
            when {
                branch 'main'
            }
            environment {
                ENV = 'prod'
            }
            options {
                timeout(time: 15, unit: "MINUTES") 
                }
            parallel {
                stage('deploy cast app') {
                    steps {
                        input message: 'Do you want to deploy in production?', ok: 'Yes!'
                        script {
                            Deploy('cast', 'cast-service')
                        }
                    }
                }
                stage('deploy movie app') {
                    steps {
                        script {
                            Deploy('movie', 'movie-service')
                        }
                    }
                }
                stage('deploy-nginx') {
                    steps {
                        script {
                            Deploy('nginx', 'nginx')
                        }
                    }
                }
            }
        }
    }
}     