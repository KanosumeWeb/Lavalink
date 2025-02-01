# Use an OpenJDK image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies (Gradle, etc.)
RUN apt-get update && apt-get install -y wget unzip

# Download Gradle wrapper
RUN wget https://services.gradle.org/distributions/gradle-7.4-bin.zip
RUN unzip gradle-7.4-bin.zip
RUN mv gradle-7.4 /opt/gradle
ENV PATH="/opt/gradle/bin:${PATH}"

# Copy the Lavalink source code into the container
COPY . /app

# Cache Gradle dependencies to speed up builds
RUN gradle clean build -x check -x test

# Expose the port Lavalink runs on (default is 2333)
EXPOSE 2333

# Command to run Lavalink
CMD ["java", "-jar", "Lavalink.jar"]
