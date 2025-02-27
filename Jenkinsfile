pipeline {
    agent any

    environment {
        IMAGE_NAME = "clumsy-bird"
        CONTAINER_NAME = "clumsy-bird-container"
        APP_PORT = "8080"    // Host machine port
        DOCKER_PORT = "80"   // Apache2 inside container
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/utkiya/clumsy-bird-master.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                script {
                    sh '''
                    docker ps -q --filter "name=$CONTAINER_NAME" | grep -q . && docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME || true
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p $APP_PORT:$DOCKER_PORT --name $CONTAINER_NAME $IMAGE_NAME"
                }
            }
        }

        stage('Post-Build Cleanup') {
            steps {
                sh 'docker image prune -f'
            }
        }
    }
}

