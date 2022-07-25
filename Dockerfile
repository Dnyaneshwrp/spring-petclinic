FROM maven:3.8.6-openjdk-11 as builder
RUN git clone https://github.com/spring-projects/spring-petclinic.git && cd spring-petclinic && mvn clean package

FROM openjdk:11-jdk-slim 
WORKDIR /app
COPY --from=builder /spring-petclinic/target/spring-petclinic-2.7.0-SNAPSHOT.jar /app
EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic-2.7.0-SNAPSHOT.jar"]
