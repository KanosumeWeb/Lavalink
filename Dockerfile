# Use an OpenJDK image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies (Maven, wget, curl)
RUN apt-get update && apt-get install -y wget curl maven

# Copy the Lavalink source code into the container
COPY . /app

# Print Java version to ensure it's correct
RUN java -version

# Resolve dependencies first
RUN mvn clean dependency:resolve

# Build the project with Maven, capturing debug logs
RUN mvn clean install -DskipTests --debug

# Expose the default Lavalink port (2333)
EXPOSE 2333

# Run the Lavalink server
CMD ["java", "-jar", "target/Lavalink.jar"]
