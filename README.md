# bootdocker


## Dockerize a Spring Boot Application

### steps involved

- Create a Spring Boot Application
- Create Dockerfile
- Build executable jar file
- Build Docker image
- Run Docker container using the image built

#### Dockerfile

```

FROM adoptopenjdk/openjdk15:ubi  # FROM:To build a Docker image using a Dockerfile,we need a base layer
ENV APP_HOME=/usr/app/  # This sets the environmental variable. APP_HOME=/usr/app/ simply assigns the directory /usr/app/ to APP_HOME
WORKDIR $APP_HOME  # This is setting up the working directory or the current directory
COPY build/libs/*.jar app.jar # copies the build the jar file using gradle into the work directory
EXPOSE 8080 # Expose sets the port number to connect to the host
CMD ["java", "-jar", "app.jar"] # this is the command that runs when the container starts or runs

```

#### Build executable jar file

### Ignore local setup if you want to build using github actions

***prerequsites***

- Install jdk 15 locally
- Install gradle
- Build the code using ./gradlew build

#### Build Docker Image and run the container

```
docker image build -t lwplapbs/bootdocker:1 .

docker run -d --name bootdocker -p 8080:8080 lwplaps/bootdocker:1

```

### Github actions process

#### The below steps are already automated using github actions

***prequsites***

create the below secrets in your repository settings with your personal docker hub values

DOCKER_PASSWORD
DOCKER_USERNAME

##### update the github actions workflow file with tyour respective docker repo details

***line 40 ***

        tags: <yourvalue>/bootdocker:${{ github.run_id }}





- Build executable jar file
- Build Docker image



