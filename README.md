[![Travis CI](https://travis-ci.org/ddewaele/springboot.crud.sample.svg?branch=master)](https://travis-ci.org/ddewaele/springboot.crud.sample/) 

## Introduction

A very sample Spring boot application running on port 8080 exposing a Spring Data REST interface for employee entities. Used for demo purposes.

```
curl http://localhost:8080/employees
curl -X POST -H "Content-Type:application/json" -d '{ "firstName" : "Karl", "lastName" : "Penzhorn" }' http://localhost:8080/employees
curl http://localhost:8080/employees/1
curl -X PUT -H "Content-Type:application/json" -d '{ "firstName" : "Karl", "lastName" : "Smith" }' http://localhost:8080/employees/1
curl http://localhost:8080/employees/1
curl -X DELETE -H "Content-Type:application/json" http://localhost:8080/employees/1
```
## Building
The sample is built using maven. 
```
mvn clean install
```

## Docker
The maven build file also generates a docker container with the name `springboot.crud.sample` and is available on [Docker HUB](https://hub.docker.com/r/ddewaele/springboot.crud.sample/).

The docker image can be started using

```
docker run --name springboot.crud.sample -t \
-p 8080:8080 \
-v /tmp/logs:/var/log \
ddewaele/springboot.crud.sample
```

You can also provide environment properties. For example if you want to run against a postgres DB, a specific profile is available:
```
docker run --name springboot.crud.sample -t \
-p 8080:8080 \
-v /tmp/logs:/var/log \
-e "SPRING_PROFILES_ACTIVE=postgres" \
ddewaele/springboot.crud.sample
```

To build the docker image yourself, execute a `maven clean install`.

## H2
By default the application uses an H2 database. The h2 console is enabled at http://localhost:8080/h2-console.

## Swagger

Swagger docs are available at http://localhost:8080/v2/api-docs

## Postgres

### Login to postgrs
```
export PATH=$PATH:/Library/PostgreSQL/9.4/bin
psql -U postgres
```
### Create the auth server DB
```
CREATE USER employee_db_user WITH PASSWORD 'employee_db_user';
CREATE DATABASE employee_db OWNER employee_db_user;
```
### Verify that you can login
```
psql -U employee_db_user -d employee_db
```

### If you want to drop and re-create
```
Ensure you kill all ongoing sessions
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'employee_db'
  AND pid <> pg_backend_pid();
```
And drop the DB

```
drop database employee_db;
```
## Data
[Mockaroo](https://www.mockaroo.com) is a great service for generating random data.
Go to the site, login with Google+ and you'll be able to download the data using curl
```
curl "https://www.mockaroo.com/2bdc4db0/download?count=1000&key=xxxxx" > "employees.csv"
```

A sample dump is located in the `data` folder of this project.

You can convert that CSV data using awk (see the parse.sh script in the data folder of this project) to either generate import statemenets or curl commands like this:
```
echo $txt | awk -F "," '{printf("INSERT INTO EMPLOYEE(FIRST_NAME,LAST_NAME,EMAIL) VALUES('\''%s'\'','\''%s'\'','\''%s'\'');\n"),$2,$3,$4}'
echo $txt | awk -F "," '{printf("curl -X POST -H \"Content-Type: application/json\" -d '\''{ \"firstName\" : \"%s\", \"lastName\" : \"%s\", \"email\" : \"%s\" }'\'' http://localhost:8080/employees\n"),$2,$3,$4}'
```

See the `parse.sh`
