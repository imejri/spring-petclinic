# Étape 1: Construire l'application en utilisant une image Maven
FROM maven:3.6.3-jdk-8-slim AS build
WORKDIR /app

# Copier le pom.xml et installer les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le code source et construire l'application
COPY src ./src
RUN mvn package -DskipTests

# Étape 2: Créer l'image de l'application en utilisant une image Java
FROM openjdk:8-jre-slim
WORKDIR /app

# Copier le fichier JAR de l'étape de construction
COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar petclinic.jar

# Exposer le port sur lequel votre application s'exécute
EXPOSE 8080

# Définir la commande pour exécuter l'application
ENTRYPOINT ["java","-jar","petclinic.jar"]
