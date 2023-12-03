/* Pipeline de Build de notre application petclinic */

pipeline {

    agent any  // Build sur le contrôleur
    options {
        timeout(time: 1, unit: 'HOURS')
    }

    environment {
        // Définir le chemin du répertoire local Maven
        MAVEN_LOCAL_REPO = "${WORKSPACE}/.m2/repository"
        MAVEN_OPTS = "-Dmaven.repo.local=${env.MAVEN_LOCAL_REPO}"
    }

    stages {

        stage ('checkout code') {
            steps {
                checkout scmGit(branches: 
                [[name: '*/pipeline-1']], userRemoteConfigs: 
                [[url: 'https://github.com/imejri/spring-petclinic.git']])
            }
        } // stage

        stage('Compilation du code') {

            steps {
                script {
                sh './mvnw compile'
                }
            }
        }

        stage('Test unitaire') {

            steps {
                sh './mvnw test'
            }
            post {
                success {

                    junit 'target/surefire-reports/*.xml'
                }
            } // post success
        }

        stage('package') {

            steps {
                sh './mvnw clean package'
            }
            post {

                // Archive des *.jar files si le build est ok
                success {
                    archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true, followSymlinks: false
                }
            } // post success
        } // stage

        stage ('build petclinic app image') {
            steps {
                script {   
                   sh 'docker build -t petclinic:0.1.0 .'
                }
            }
        } // stage

        stage ('Start petclinic container') {
            steps {
                script {   
                   sh 'docker run -d --name petclinic-app-${BUID_NUMBER} -p 8081:8080 petclinic:0.1.0'
                }
            }
        } // stage
    }

    post {
        success {
            echo 'Build application successfull'
        }
    }
}