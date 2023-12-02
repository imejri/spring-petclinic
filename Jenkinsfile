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
        }
        stage('package') {

            steps {
                sh './mvnw clean package'
            }
        }
    }
    post {
        success {
            echo 'Build application successfull'
        }
    }
}