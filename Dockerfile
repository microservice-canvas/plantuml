FROM openjdk:8u181-jdk-stretch
WORKDIR /plantuml
RUN apt-get update -y && apt-get -y install graphviz=2.38.0-17 imagemagick
RUN wget http://sourceforge.net/projects/plantuml/files/plantuml.1.2019.11.jar/download && mv download plantuml.1.2019.11.jar
CMD ./run-plantuml.sh
COPY legends legends
COPY run-plantuml.sh .
RUN chmod +x run-plantuml.sh
