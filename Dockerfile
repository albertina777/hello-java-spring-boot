# Stage 1: Build the application using Maven with Red Hat UBI and OpenJDK
FROM registry.access.redhat.com/ubi8/openjdk-11 AS build
USER root
WORKDIR /app

# Install Maven manually (UBI doesn't include Maven)
RUN microdnf install -y maven && \
    microdnf clean all

COPY . .
RUN mvn clean install -DskipTests

# Stage 2: Runtime with smaller footprint using Red Hat UBI OpenJDK 11
FROM registry.access.redhat.com/ubi8/openjdk-11-runtime
WORKDIR /app

COPY --from=build /app/target/hello-java-spring-boot-*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
