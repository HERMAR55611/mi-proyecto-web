pipeline {
  agent any
  environment {
    IMAGE_NAME = "miapp-nginx"
    IMAGE_TAG  = "build-${BUILD_NUMBER}"
    CONTAINER_NAME = "web1"
    HOST_PORT = "8080"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
          branches: [[name: '*/main']],
          userRemoteConfigs: [[url: 'git@github.com:Dannamo34/mi-lab-nginx.git', credentialsId: 'git-ssh-key']]
        ])
      }
    }
    stage('Build Docker image') {
      steps {
        sh '''
          set -eux
          docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
        '''
      }
    }
    stage('Run container') {
      steps {
        sh '''
          set -eux
          # Elimina el contenedor si existe
          docker rm -f ${CONTAINER_NAME} || true
          # Ejecuta el contenedor en el puerto 9090
          docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:80 --restart unless-stopped ${IMAGE_NAME}:${IMAGE_TAG}
          # Sleep opcional para esperar a que Nginx levante
          sleep 3
        '''
      }
    }
  }
  post {
    always {
      sh 'docker ps'
    }
  }
}