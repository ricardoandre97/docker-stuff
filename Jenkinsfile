pipeline {
    agent any
    stages {

        stage('Checkout') {
            checkout scm
            }

        stage('Build') {
            steps {
                sh 'echo "Hello World"'
                sh '''
                    echo $(date +%Y%m%d%H%M) > tmp
                    version=$(cat tmp)
                    docker build -t nginx:$version -f Dockerfile .
                    docker run -d -p 9090:80 --name nginx-tmp nginx:$version 
                '''
            }
        }
    }
}
