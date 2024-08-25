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

    parameters {
        string(name: 'VERSION', defaultValue: '', description: 'Put image Version')
    }

    stages {

        stage ('checkout code') { // clone du code avec le dernier commit
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

                    junit 'target/surefire-reports/*.xml' // Export des rapports Junit
                }
            } // post success
        }

        stage('package') { //création du jar

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

        stage('launch application') { //démarrage de l'app spring petclinc

            steps {
                sh 'nohup java -jar $WORKSPACE/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar &'
            }
            post {

                // Archive des *.jar files si le build est ok
                success {
                    echo " --- l'application spring petclinic démarre avec succès ---"
                    echo "--- Pour se connecter: http://jenkins.lab.local:8081 ---"
                }
            } // post success
        } // stage

        /* stage ('build petclinic app image') {
            steps {
                script {   
                    if ( params.VERSION.isEmpty() )
                        {
                            currentBuild.result = "FAILURE"
                            throw new Exception("The Parameters VERSION is empty")
                        }

                   sh "docker build -t petclinic:${params.VERSION} ."
                }
            }
        } // stage

        stage ('Start petclinic container') {
            steps {
                script {  

                   sh '''
                    docker ps -q --filter "name=petclinic-app" | xargs -r docker stop
                    '''

                   sh """
                    docker run -d --name petclinic-app-${BUILD_NUMBER} -p 8081:8080 petclinic:${params.VERSION}
                    """
                } // script
            } //steps
            post {
                failure {              
                   
                    sh 'docker ps -q --filter "name=petclinic-app" | xargs -r docker start'
            } // failure
        } //post 

        } // stage */
    } //stages

    post {
        success {
            echo 'Build application successfull'  
        }
    } //post
} // pipeline
