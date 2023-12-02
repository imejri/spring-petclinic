/* Pipeline de Build de notre application petclinic */

pipeline {
    agent any  // Build sur le contrôleur
    stages {
        stage('Compilation du code') {

            steps {
                mvnw compile
            }
        }
    }
    post {
        success {
            echo 'Build application successfull'
        }
    }
}