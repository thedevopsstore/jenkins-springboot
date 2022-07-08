#!groovy

pipeline {
    agent any

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
                sh 'ls -ltr build/libs/'
                stash 'source'
            }
        }
        stage('build image'){
            steps {
                /*docker.withRegistry('', 'docker_creds') {
                    docker.build('lwplapbs/springboot').push('latest')
                } */
                //DOCKER_TAG="lwplapbs/bootdocker" + ":{BUILD_NUMBER}"
                // app = docker.build("DOCKER_TAG")
                // app.push()
                unstash 'source'
                sh '''
                ls -ltr build/libs/
                docker image build -t lwplapbs/springboot:latest  .
                docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
                docker push lwplapbs/springboot:latest
                '''
            }    
            }
stage ('Deploy') {
    steps{
        sshagent(credentials : ['docker-ssh']) {
            sh 'ssh -o StrictHostKeyChecking=no azureuser@20.125.120.113 uptime'
            sh 'ssh -v azureuser@20.125.120.113'
            sh 'sudo docker container run -d --name springboot1 lwplapbs/springboot:latest'
        }
    }
}
    }

}