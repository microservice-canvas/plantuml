FROM amazoncorretto:8u382-al2
WORKDIR /plantuml
RUN yum -y --setopt=skip_missing_names_on_install=False install graphviz-2.30.1 ImageMagick wget && \
    yum clean all && \
    rm -rf /var/cache/yum
RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2023.10/plantuml-1.2023.10.jar
CMD ./run-plantuml.sh
COPY legends legends
COPY run-plantuml.sh .
RUN chmod +x run-plantuml.sh
