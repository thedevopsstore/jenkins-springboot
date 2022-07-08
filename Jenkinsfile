#!groovy

pipeline {
    agent none

    environment {
        DOCKERHUB = credentials('docker_creds')
    }

options {
    timestamps()
    skipDefaultCheckout(true)
}

    stages {
        stage('Build code') {
            agent {
                docker {
                    image 'gradle:jdk15'
                }
            }

            steps {
                cleanWs()
                checkout scm
                sh 'chmod +x gradlew'
                sh './gradlew build'
                sh 'docker image build'
                stash 'source'
            }
        }
        /* stage('build image'){
            steps{ script {
                DOCKER_TAG="lwplapbs/bootdocker" + ":{BUILD_NUMBER}"
                app = docker.build("DOCKER_TAG")
                docker image build -t $DOCKER_TAG .
                docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                docker push $DOCKER_TAG
            }    
            }
        }
    } */
        stage('build image'){
            agent {label 'worker'}
            steps {
                DOCKER_TAG="lwplapbs/bootdocker" + ":{BUILD_NUMBER}"
                // app = docker.build("DOCKER_TAG")
                docker image build -t $DOCKER_TAG .
                docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                docker push $DOCKER_TAG
            }    
            }
        }
    }

}