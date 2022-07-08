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
                stash 'source'
            }
        }
        stage('build image'){
            steps{ script {
                /*docker.withRegistry('', 'docker_creds') {
                    docker.build('lwplapbs/springboot').push('latest')
                } */
                //DOCKER_TAG="lwplapbs/bootdocker" + ":{BUILD_NUMBER}"
                // app = docker.build("DOCKER_TAG")
                // app.push()
                ls -ltr
                docker image build -t lwplapbs/springboot:latest  .
                docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                docker push $DOCKER_TAG
            }    
            }
        }
    }

}