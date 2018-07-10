pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                sh '''
                    echo $(date +%Y%m%d%H%M) > tmp
                    version=$(cat tmp)
                    docker build -t nginx:$version -f Dockerfile .
                '''
            }
		}
        stage('tests') {
            steps {
                sh '''
                    version=$(cat tmp)
                    docker run -d -p 9090:80 --name tmp-$version nginx:$version
                    for i in $(seq 1 6) ; 
                      do curl -s http://localhost:9090
                        if [ $? -ne 0 ]; then
                          echo Tests didnt pass
                          exit 1
                        fi
                    done
                    echo Tests passed
                    docker rm -fv tmp-$version
                '''
            }
		}
    }
}
