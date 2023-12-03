# Étape 1: Construire l'application en utilisant une image Maven
FROM openjdk:8-jre-slim

# Copier le fichier JAR de l'étape de construction
COPY  target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar petclinic.jar

# Exposer le port sur lequel votre application s'exécute
EXPOSE 8000

# Définir la commande pour exécuter l'application
ENTRYPOINT ["java","-jar","petclinic.jar"]
