throttle(['throttleTest']) {
  node('test') {
    wrap([$class: 'AnsiColorBuildWrapper']) {
      try{
        stage('Setup') {
          checkout scm
          sh '''
            ls
            pwd
          '''
        }
        stage('Build'){
          sh '''
            echo $(date +%Y%m%d%H%M) > tmp
            version=$(cat tmp)
            docker build -t nginx:$version -f Dockerfile .
            docker run -d -p 9090:80 --name nginx-tmp nginx:$version 
          '''
        }
        stage('Tests') {
          sh '''
            for i in {1..6} ; 
              do curl http://localhost:9090
              if [ $? -ne 0 ]; then
                echo Something went wrong
                exit 1
              fi
            done
            echo Tests passed
          '''
        }
        stage('Deploy') {
          sh '''
            version=$(cat tmp)
            docker run -d -p 8787:80 --name nginx-$version nginx:$version 
          '''
        }
      }
      finally {
        stage('Cleanup') {
          sh '''
            docker rm -fv nginx-tmp
          '''
        }
      }
    }
  }
}
