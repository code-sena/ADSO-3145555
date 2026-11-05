FROM liquibase/liquibase:5.0.2

USER root

RUN mkdir -p /liquibase/lib

ADD https://jdbc.postgresql.org/download/postgresql-42.7.8.jar /liquibase/lib/postgresql.jar

ENV LIQUIBASE_CLASSPATH=/liquibase/lib/postgresql.jar