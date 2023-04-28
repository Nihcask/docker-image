pipeline{
    agent {
  label 'docker'
} 
environment {
		DOCKER_LOGIN_CREDENTIALS=credentials('docker')
	}
    stages {
  stage('checkout') {
    steps {
      echo 'checkout stage'
    }
  }

  stage('build') {
    steps {
      
      sh 'docker build -t sachink0912/multi_stage_image:$BUILD_NUMBER .' 

    }
  }

  stage('push') {
    steps {
      sh 'echo $DOCKER_LOGIN_CREDENTIALS_PSW | docker login -u $DOCKER_LOGIN_CREDENTIALS_USR --password-stdin'
      sh 'docker push sachink0912/multi_stage_image:$BUILD_NUMBER'
    }
  }

  stage('deploy') {
    steps {
      sh "docker run -itd -p 80:8080 sachink0912/multi_stage_image:$BUILD_NUMBER"
    }
  }

}

}
