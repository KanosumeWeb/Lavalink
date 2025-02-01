# Use an OpenJDK image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y wget unzip curl

# Download and install Gradle wrapper
RUN wget https://services.gradle.org/distributions/gradle-7.4-bin.zip -O /tmp/gradle.zip
RUN unzip /tmp/gradle.zip -d /opt && rm /tmp/gradle.zip
RUN mv /opt/gradle-7.4 /opt/gradle
ENV PATH="/opt/gradle/bin:${PATH}"

# Copy the Lavalink source code into the container
COPY . /app

# Print Java version to ensure it is correct
RUN java -version

# Run the Gradle build command
RUN ./gradlew clean build -x check -x test --stacktrace

# Expose the Lavalink port (default 2333)
EXPOSE 2333

# Run the Lavalink server
CMD ["java", "-jar", "Lavalink.jar"]
