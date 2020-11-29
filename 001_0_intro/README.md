# Kubernetes Intro
Kubernetes is one of the essential technologies to lean in 2020 or 2021. Kubernetes is essential   
skills of not just every DevOps Engineers, but every backend developer or manager 
should know at least the basics of Kubernetes.

# Introduction
We will cover the following things in this blogpost
* Kubernetes high level intro
* Kubernetes hello world
* Kubernetes concepts
    * Pods
    * Services
    * Deployments
* Other important things
    * Volumes
    * ConfigMaps and Secrets


Let's first look at a simple kubernetes example to understand the power of Kubernetes

# Kubernetes high level intro
In modern day apps to deploy a software application following steps are needed
1) Writing of the code/logic
2) Continuous integration to unit test the application code
3) Packaging the code
4) Running the code on server

Since apps have to manage quite some dependencies, the most reliable way to package and run the app 
is using container. Docker is industry wide standard these days.

To orchestrate containers we need a software or a framework and Kubernetes is the most widely used
container orchestration technology that is used these days.

Things like creating replicas, load balancing requests, doing incremental deployments, adding health checks,
managing configurations and secrets can all be done in Kubernetes in a few lines of code

# Kubernetes hello world
In this example we create a simple node js server which increments a counter 
every time it gets a request and returns the response of the format `Hello world <<counter>> from <<hostname>>`
Here counter reflects the number of requests received by the server and hostname is the hostname on which
the process is running. 

Some other details to note are
1. We set the header `response.setHeader("Connection", "close")` which makes sure that the connection 
is closed by browser after it get's the response
2. We build the app using docker and tag it using the command `docker build . -t robinnagpal/kubernetes-tutorial-001-node-app`
3. We then push this to docker repository

Deploy to Kubernetes
1. We now are going to use this app and run 5 replicas or copies in parallel
2. We are going to load balance these using a service in a round robin manner
3. We then expose it to the outside world

When we now send requests from our browser we see that everytime it hits a different container

# Understanding what is involved
As we said earlier, there are primary four steps involved in developing and deploying the applications
1) Step 1 - Application Development - Here we use NodeJS to write a simple application which replies back to HTTP requests
2) Step 2 - Continuous Integration - We skipped this part to keep things simple
3) Step 3 - Packaging Application - We have docker here. Dockerfile within the directory tells how to package the app.
This is how the docker file looks like

```dockerfile
FROM node:12

COPY . .
WORKDIR .

RUN npm install
ENTRYPOINT ["npm", "start"]
``` 

We use this docker file to build an image 
