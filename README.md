
# Pintu SRE Requirement

PINTU <> Technical Assessment <> Site Reliability Engineer - WEB 3

# kubernetes-manifest

A Kubernetes manifest file is personal guide through a Kubernetes cluster: A configuration file written in a format called YAML or JSON, that describes the resources for cluster.

The YAML configuration is called a “manifest”, and when it is “applied” to a Kubernetes cluster, Kubernetes creates an object based on the configuration. A Kubernetes Deployment YAML specifies the configuration for a Deployment object—this is a Kubernetes object that can create and update a set of identical pods.

In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in cluster.

# public

The file public/index. html is a template that will be processed with html-webpack-plugin. During build, asset links will be injected automatically.

# .dockerignore

dockerignore file for ignore files and folders in the docker build for developers. . dockerignore is a docker ignore file similar to a . gitignore file. It contains all files and folders to exclude during building the docker image.

# .gitlab-ci.yaml

The . gitlab-ci. yml file defines scripts that should be run during the CI/CD pipeline and their scheduling, additional configuration files and templates, dependencies, caches, commands GitLab should run sequentially or in parallel, and instructions on where the application should be deployed to.

in gitlab-ci.yaml, there are 2 stages, install and build, after successful build, the docker image will be pushed to the public registry, and the kubernetes manifest (deployment.yaml) will be pulled to run the app

gitlab ci/cd is easy to use, accelerated time-to-value

Public Repository
https://hub.docker.com/r/zenabar/nodejs/tags

# Dockerfile

FROM node:16-alpine (This image is based on the popular Alpine Linux project, available in the alpine official image. Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.) 

ENV TZ UTC (timezone utc)
WORKDIR /app (The WORKDIR instruction in a Dockerfile sets the current working directory for subsequent instructions in the Dockerfile.) 

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone (for setting timezone)

RUN apk update && \ (make sure that the package list is up-to-date. So always get the latest version of the package want to install.)
    apk -f upgrade &&\ 
    apk add tini \ (Tini is a tiny and simplest init available for containers. It works by spawning a single child and waiting for it to exit while reaping the zombie processes as well as performing signal forwarding.)
        curl \ (command line tool that enables data transfer over various network protocols)
        openssl \ (OpenSSL is an open-source command line tool that is commonly used to generate private keys, create CSRs, install your SSL/TLS certificate, and identify certificate information.)
        ca-certificates \ (A certificate authority (CA) is a trusted entity that issues Secure Sockets Layer (SSL) certificates. These digital certificates are data files used to cryptographically link an entity with a public key.)
        bzip2 (bzip2 compresses data in blocks of size between 100 and 900 kB and uses the Burrows–Wheeler transform to convert frequently-recurring character sequences into strings of identical letters)

COPY --chown=node:node . . (change ownership to node:node)

USER node
EXPOSE 3001 ( container listens for traffic on the specified port)

ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "node", "dist/index.js" ]

#       
