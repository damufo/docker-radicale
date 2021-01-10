# Radicale Docker

This repository contains a sample for running [Radicale](https://github.com/Kozea/Radicale) inside docker.

It uses a python container to run Radicale and an nginx container for access and user authentication.

## Prerequisites

* Docker
* Docker Compose
* Access to Docker Hub or python and nginx base images
* Access to Alpine package repository and PyPI repository or offline packages and files

## Configuration

In order to restrict access to Radicale edit the [credentials file](htpasswd) and fill in your credentials. Default credentials are `admin:admin`.

### Optional configuration 

To enable versioning of your data you can enable GIT support. GIT gets installed per default in the [radicale docker file](radicale.dockerfile).

1. Uncomment the storage hook for GIT inside the [radicale configuration file](radicale.conf).
1. Initialize an empty GIT repository inside [radicale data folder](radicale_data):
   ```bash
   git init
   ```
1. Set the user information for GIT commits inside the GIT repository:
   ```
   git config user.email ""
   git config user.name "Radicale"
   ```

## Start

Fire up radicale and nginx:
```
docker-compose up
```

You can now access the radicale webinterface on your [local machine](http://localhost:8080).
