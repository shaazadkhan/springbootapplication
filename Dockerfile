FROM openjdk:17-alpine

EXPOSE 8081

COPY ./target/*.jar springbootapplicationservices.jar

ENTRYPOINT ["java", "-jar", "springbootapplicationservices.jar"]
