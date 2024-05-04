pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage("Checkout") {
            steps {
                checkout scm
            }
        }
        stage("Docker Build") {
            steps {
               sh '''
                   #oc start-build --from-build=<build_name>
                   oc start-build -F hello-java-spring-boot --from-dir=.
               '''
            }
        }
         stage("Deploy to DEV") {
            steps {
               sh '''
                   oc new-app quay.io/adacunha-1/hello-springboot:latest
               '''
            }
        }
    }
}
