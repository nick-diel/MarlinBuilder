FROM ubuntu:latest

RUN apt-get update
RUN apt-get install curl -y

#Install Arudino CLI
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/usr/local/bin sh

# Copy Build File
COPY ./compile.sh /usr/local/bin

ENTRYPOINT [ "compile.sh" ]
