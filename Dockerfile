#Without Stage Build
#FROM maven:3.8.5-openjdk-17
#
#WORKDIR .
#COPY . .
#RUN mvn clean install
#
#CMD mvn spring-boot:run

# Build stage
FROM maven:3.8.1-openjdk-17 AS builder

# Set working directory inside the container
WORKDIR .

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project and build it
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:17-jdk-alpine
#FROM eclipse-temurin:17-jdk-jammy

# Set the working directory and copy the jar file from the build stage
WORKDIR .
COPY --from=builder ./target/DockerTutorial-*.jar ./DockerTutorial.jar

# Expose the port and define the entry point
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "./DockerTutorial.jar"]