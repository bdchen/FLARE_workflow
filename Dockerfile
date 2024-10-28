FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget default-jre

RUN wget https://faculty.washington.edu/browning/flare.jar

COPY test_data/* /test_data