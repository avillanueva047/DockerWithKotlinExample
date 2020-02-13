ARG VERSION=8u151

FROM openjdk:${VERSION}-jdk as BUILD

COPY . /src
WORKDIR /src
COPY build.gradle build.gradle
RUN ./gradlew --no-daemon shadowJar

FROM openjdk:${VERSION}-jre

COPY --from=BUILD /src/build/libs/*.jar /bin/runner/run.jar
WORKDIR /bin/runner

CMD ["java","-jar","run.jar"]
