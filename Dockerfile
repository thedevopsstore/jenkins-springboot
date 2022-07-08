FROM adoptopenjdk/openjdk15:ubi
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY build/libs/*SANPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]