# Базовый образ, содержащий java
FROM openjdk:11-slim as build
WORKDIR application
# Добавили инфу о владельце
LABEL maintainer="Vasya Pupkin <v.pupkin@65apps.com"
# Добавили переменную JAR_FILE
ARG JAR_FILE=target/*.jar
# Добавить файл jar приложения в контейнер
COPY ${JAR_FILE} application.jar
# Распаковать файл jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:11-slim
WORKDIR application
VOLUME /tmp
COPY --from=build application/dependencies/ ./
COPY --from=build application/spring-boot-loader/ ./
COPY --from=build application/snapshot-dependencies/ ./
COPY --from=build application/application/ ./
# Запустить приложение
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
