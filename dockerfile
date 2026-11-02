# Etapa 1: Compilación con Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
# Etapa 2: Ejecución ligera con Java 17
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

## Etapa 1: Compilación del JAR
#FROM maven:3.9.6-eclipse-temurin-21 AS build
#WORKDIR /app
#COPY . .
#RUN mvn clean package -DskipTests
## Etapa 2: Ejecución del contenedor
#FROM eclipse-temurin:21-jre-jammy
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "app.jar"]