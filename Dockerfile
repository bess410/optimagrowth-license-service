# Базовый образ, содержащий java
FROM openjdk:11-slim as build
# Добавили инфу о владельце
LABEL maintainer="Vasya Pupkin <v.pupkin@65apps.com"
# Добавили переменную JAR_FILE
ARG JAR_FILE
# Добавить файл jar приложения в контейнер
COPY ${JAR_FILE} app.jar
# Распаковать файл jar
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf /app.jar)
FROM openjdk:11-slim
VOLUME /tmp
ARG DEPENDENCY=/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
# Запустить приложение
ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.optimagrowth.license.LicenseServiceApplication"]
