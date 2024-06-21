# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    apt-utils \
    sudo \
    git \
    unzip \
    wget \
    rsync \
    curl \
    ssh \
    xinetd \
    vim \
    nano

ARG USER_ID
ARG USER_GROUP

RUN echo "Inside the container, USER_ID is $(USER_ID)" && echo "USER_GROUP is $(USER_GROUP)"
RUN echo "Inside the container, USER_ID is $(id -u)" && echo "USER_GROUP is $(id -g)"

# Set environment variable for interactive bash shells
RUN echo "alias ll='ls -la'" >> ~/.bashrc \
    && chown ${USER_ID}:${USER_ID} ~/.bashrc

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
