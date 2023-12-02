/* Pipeline de Build de notre application petclinic */

pipeline {
    agent any  // Build sur le contrôleur
    options {
        timeout(time: 1, unit: 'HOURS')
        // Configuration du cache Maven
        mavenLocalRepo '.m2/repository'
    }
    stages {
        stage('Compilation du code') {

            steps {
                sh './mvnw compile'
            }
        }
        stage('Test unitaire') {

            steps {
                sh './mvnw test'
            }
        }
    }
    post {
        success {
            echo 'Build application successfull'
        }
    }
}