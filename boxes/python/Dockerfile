# python
#
# VERSION               0.0.2

# Change this for different versions of ruby (see https://hub.docker.com/_/python/)
# FROM python:3.5-slim
# FROM python:3.4-slim
FROM python:slim


ENV APP_HOME ~

# silence deb warnings
ENV DEBIAN_FRONTEND noninteractive
ENV HOSTNAME pixiebox

# add repository software
RUN apt-get update

## Tools

# utils
RUN apt-get install -y sudo nano wget git gcc openssh-client build-essential

# set working dir
WORKDIR $APP_HOME

# hook up source files
ADD . $APP_HOME