pipeline {
    agent {
        label 'docker-daemon'
    }

    stages {
        agent {
            dockerfile {
                filename 'Dockerfile'
            }
        }
        stage('create_dailybuild_dir') {
            steps {
                sh 'bash create_dailybuild_conf.sh'
            }
        }
        stage('create_iso') {
            steps {
                sh 'bash create_iso.sh'
            }
        }
    }
}