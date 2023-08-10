# Use an official Gradle image as the build environment
FROM gradle:7.2.0-jdk11 AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the Spring Boot application
RUN gradle build

# Use an official OpenJDK runtime image as the base image
FROM openjdk:11-jre-slim

# Set the working directory within the container
WORKDIR /app

# Copy the JAR from the build environment into the container
COPY --from=build /app/build/libs/spring-boot-github-action-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that your Spring Boot app will listen on
EXPOSE 8080

# Specify the command to run your Spring Boot app when the container starts
CMD ["java", "-jar", "app.jar"]
