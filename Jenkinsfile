pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        IMAGE_NAME = 'PythonMagix'
        IMAGE_TAG = 'v5'
        APP_ENV = "dev"
    }
    stages {
        stage('Build') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Test') {
            steps {
                sh 'pytest tests/'
            }
        }
        stage('Package') {
            steps {
                sh 'tar -czf app.tar.gz *'
            }
        }
        stage('Artifacts') {
            steps {
                archiveArtifacts artifacts: 'app.tar.gz', fingerprint: true
            }
        }
        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS,
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker build -t PythonMagix:v5 .'
                    sh 'docker push PythonMagix:v5'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker rm -f flaskapp || true'
                sh 'docker run -d -p 5052:5052 --name flaskapp PythonMagix:v5'
            }
        }
        stage('Environment') {
            steps {
                sh 'echo "Running in $APP_ENV environment"'
            }
        }
    }
}
