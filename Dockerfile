FROM openjdk:17.0.2-jdk-slim as build
WORKDIR application
COPY . .
RUN ./gradlew --no-daemon installDist

FROM openjdk:17.0.2-jdk-slim
WORKDIR application
RUN apt-get update && apt-get install -y procps
COPY --from=build application/build/install/org.openmbee.flexo.mms.store-service/ .
ENTRYPOINT ["./bin/org.openmbee.flexo.mms.store-service"]
EXPOSE 8080
