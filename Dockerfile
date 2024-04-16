# Build Step
FROM maven:3-amazoncorretto-17 as build

#Set working directory
WORKDIR /opt

# Copy Project
COPY . .

# Build project
RUN mvn clean install -DskipTests



# Run Step
FROM maven:3-amazoncorretto-17

ARG JAR_FILE=sladeappspring-0.0.1-SNAPSHOT.jar

#Set working directory
WORKDIR /opt

# Copy Jar
COPY --from=build opt/target/${JAR_FILE} /opt/sladeappspring.jar

# Expose port
EXPOSE 8080:8080

# Start app
ENTRYPOINT ["java", "-jar", "/opt/sladeappspring.jar"]