pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                sh '''
                    echo $(date +%Y%m%d%H%M) > tmp
                    version=$(cat tmp)
                    docker-compose build
                '''
            }
		}
        stage('tests') {
            steps {
                sh '''
                    version=$(cat tmp)
                    docker-compose up -d
                    for i in $(seq 1 6) ; 
                      do curl -s http://localhost:9090
                        if [ $? -ne 0 ]; then
                          echo Tests didnt pass
                          exit 1
                        else
                          echo Tests passed
                        fi
                    done
                    docker-compose down
                '''
            }
		}

        stage('Deploy') {
            steps {
                sh '''
                    export version=$(cat tmp)
                    docker-compose -f docker-compose.yml up -d
                '''
            }
		}
    }
}
