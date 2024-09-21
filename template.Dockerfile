# Build stage using Maven with Temurin JDK 21
FROM eclipse-temurin:21 AS builder

# Set the working directory inside the container for the build
WORKDIR /usr/src/app

# Copy only the pom.xml file first to leverage Docker's layer caching for dependencies
COPY pom.xml .

# Pre-fetch Maven dependencies to use caching and speed up subsequent builds
RUN mvn dependency:go-offline -B

# Copy the source code (after caching dependencies)
COPY src ./src

# Package the application, skipping tests to speed up the build process
RUN mvn clean package -DskipTests

# Runtime stage using a slim Temurin JRE for running the application
FROM eclipse-temurin:21

# Set the working directory inside the container for running the app
WORKDIR /usr/src/app

# Expose the port your application will run on (adjust if necessary)
EXPOSE 8080

# Copy the JAR file from the build stage
COPY --from=builder /usr/src/app/target/*.jar /usr/src/app/app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "/usr/src/app/app.jar"]
