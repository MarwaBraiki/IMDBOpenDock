# Build stage with Temurin JDK 21 and Maven
FROM eclipse-temurin:21 AS builder

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Maven project files
COPY pom.xml ./
# Fetch all dependencies to cache them
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Package the application, skipping tests to speed up the build
RUN mvn clean package -DskipTests

# Base image for running the application using Temurin JDK 21
FROM eclipse-temurin:21

# Set the working directory inside the container
WORKDIR /usr/src/app

# Expose the application port
EXPOSE 8080

# Copy the JAR from the build stage
COPY --from=builder /usr/src/app/target/*.jar /usr/src/app/app.jar

# Entrypoint and command to run the application
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]
