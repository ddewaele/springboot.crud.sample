FROM amazoncorretto:19.0.1

ARG JAR_NAME
ADD target/${JAR_NAME} /app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app.jar" ]
