FROM openjdk:8u181-jdk-stretch
WORKDIR /plantuml
RUN apt-get update -y && apt-get -y install graphviz=2.38.0-17
#RUN wget https://graphviz.gitlab.io/pub/graphviz/stable/SOURCES/graphviz.tar.gz && tar xf graphviz.tar.gz && (cd graphviz-2.40.1 ; (./configure && make install))
CMD java -jar *.jar  -Djava.awt.headless=true /diagrams/${UML_DIAGRAM?}
RUN wget http://sourceforge.net/projects/plantuml/files/plantuml.1.2019.11.jar/download && mv download plantuml.1.2019.11.jar
