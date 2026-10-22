FROM eclipse-temurin:25-jdk
# postgresql-client: pg_dump for "نسخ قاعدة البيانات" (ARCHIVE.frm m33 BACKUP DATABASE)
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg postgresql-client; rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]