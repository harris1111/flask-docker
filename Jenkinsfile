pipeline {
  agent none

  environment {
    DOCKER_IMAGE = 'harris1111/flask-docker'
    /* groovylint-disable-next-line DuplicateStringLiteral */
  }
    stage("build") {
      agent { node {label 'master'}}
      environment {
        DOCKER_TAG="${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}"
      }
      steps {
        sh "sudo apt update"
        sh "sudo apt -V install gnupg2 pass"
        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} . "
        sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
        sh "docker image ls | grep ${DOCKER_IMAGE}"
        /* groovylint-disable-next-line LineLength */
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'harris1111', passwordVariable: 'a22Jju$xSe84tV4q')]) {
            sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
            sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
            sh "docker push ${DOCKER_IMAGE}:latest"
        }

        //clean to save disk
        sh "docker image rm ${DOCKER_IMAGE}:${DOCKER_TAG}"
        sh "docker image rm ${DOCKER_IMAGE}:latest"
      }
    }
  }

  post {
    success {
      echo 'SUCCESSFUL'
    }
    failure {
      echo 'FAILED'
    }
  }
}
