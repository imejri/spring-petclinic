# Étape 1: Construire l'application en utilisant une image Maven
## Premier stage de nom build
FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app

# Copier le pom.xml et installer les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source et construire l'application
COPY src ./src
RUN mvn package -DskipTests

# Étape 2: Créer l'image de l'application en utilisant une image Java
## second stage de démarrage de l'application
FROM openjdk:8-jre-slim
WORKDIR /app

# Copier le fichier JAR de l'étape de construction
COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar petclinic.jar

# Exposer le port sur lequel votre application s'exécute
EXPOSE 8080

# Définir la commande pour exécuter l'application
ENTRYPOINT ["java","-jar","petclinic.jar"]
