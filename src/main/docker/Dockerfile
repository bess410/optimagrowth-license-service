# Базовый образ, содержащий java
FROM openjdk:11-slim
# Добавили инфу о владельце
LABEL maintainer="Vasya Pupkin <v.pupkin@65apps.com"
# Добавили переменную JAR_FILE
ARG JAR_FILE
# Добавить файл jar приложения в контейнер
COPY ${JAR_FILE} app.jar
# Запустить приложение
ENTRYPOINT ["java", "-jar", "/app.jar"]