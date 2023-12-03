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

                    junit 'petclinic-app/target/surefire-reports/*.xml'
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
    }

    post {
        success {
            echo 'Build application successfull'
        }
    }
}