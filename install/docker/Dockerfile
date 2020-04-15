FROM debian:latest

MAINTAINER teuton 2.1

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y ruby
RUN gem install teuton

EXPOSE 80

CMD ["/bin/bash"]
