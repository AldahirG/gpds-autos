# Etapa de construcción
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copiar archivos del proyecto
COPY gpds-autos/pom.xml .
COPY gpds-autos/src ./src

# Construir el proyecto con Maven
RUN mvn clean package

# Etapa de ejecución
FROM openjdk:17
WORKDIR /app

# Copiar el archivo JAR generado en la etapa de construcción
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto en el que corre la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
