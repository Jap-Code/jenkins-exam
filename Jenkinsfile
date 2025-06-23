pipeline {
    environment {
        DOCKER_ID = "jan986"
        // DOCKER_IMAGE = "jenkins-ex"
        DOCKER_TAG = "v.0.${BUILD_ID}.0"
    }
    agent any
    stages {
        // stage('Image Build') {
        //     parallel {
        //         stage('Docker Build Cast Service') {
        //             steps {
        //                 script {
        //                     sh '''
        //                     docker rm -f jenkins
        //                     docker build -t $DOCKER_ID/movie-service:$DOCKER_TAG ./cast-service
        //                     '''
        //                 }
        //             }
        //         }
        //         stage('Docker Build Movie Service') {
        //             steps {
        //                 script {
        //                     sh '''
        //                     docker build -t $DOCKER_ID/cast-service::$DOCKER_TAG ./movie-service
        //                     '''
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage('Image Push') {
        //     environment {
        //         DOCKER_PASS = credentials("DOCKER_HUB_PASS")
        //     }
        //     parallel {
        //         stage('Docker Push Cast Service') {
        //             steps {
        //                 script {
        //                     sh '''
        //                     docker login -u $DOCKER_ID -p $DOCKER_PASS
        //                     docker push $DOCKER_ID/movie-service:$DOCKER_TAG
        //                     '''
        //                 }
        //             }
        //         }
        //         stage('Docker Push Movie Service') {
        //             steps {
        //                 script {
        //                     sh '''
        //                     docker login -u $DOCKER_ID -p $DOCKER_PASS
        //                     docker push $DOCKER_ID/cast-service:$DOCKER_TAG 
        //                     '''
        //                 }
        //             }
        //         }
        //     }
        // }
        stage('deploy:dev') {
            parallel {
                environment {
                    ENV = 'dev'
                    KUBECONFIG = credentials("config")
                }
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




    