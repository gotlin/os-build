pipeline {
    agent { label 'dailybuild' }
    stages {
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