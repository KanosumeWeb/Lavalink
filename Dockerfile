FROM openjdk:17-jdk-slim

WORKDIR /app

COPY . /app

RUN ./mvnw clean install

CMD ["java", "-jar", "Lavalink.jar"]
