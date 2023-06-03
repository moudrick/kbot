pipeline {
agent any
    
    environment {
        REPO = 'https://github.com/moudrick/kbot'
        BRANCH = 'main'
    }
    stages {
        stage('clone') {
            steps {
                echo 'CLONE REPOSITORY'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        stage('test') {
            steps {
                echo 'TEST EXECUTION STARTED'
                sh 'make test'
            }
        }
        stage('build') {
            steps {
                echo 'BUILD EXECUTION STARTED'
                sh 'make build'
            }
        }
        stage('image') {
            steps {
                script {
                    echo 'IMAGE BUILD STARTED'
                    sh 'make image'
                }
            }
        }
        stage('push') {
            steps {
                script {
                    
                    echo 'PUSH BUILD STARTED'
                    docker.withRegistry('', '.dockerhub') {
                    sh 'make push'
                    }
                }
            }
        }
    }
}
