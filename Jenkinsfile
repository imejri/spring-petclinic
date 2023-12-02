/* Pipeline de Build de notre application petclinic */

pipeline {
    agent any  // Build sur le contrôleur
    options {
        timeout(time: 1, unit: 'HOURS')
    }
    environment {
        // Définir le chemin du répertoire local Maven
        MAVEN_LOCAL_REPO = "${WORKSPACE}/.m2/repository"
    }
    stages {
        stage('Compilation du code') {

            steps {
                scripts {
                env.MAVEN_OPTS = "-Dmaven.repo.local=${env.MAVEN_LOCAL_REPO}"
                sh './mvnw compile'
                }
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