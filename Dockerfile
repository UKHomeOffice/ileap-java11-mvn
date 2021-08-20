### BUILD image
FROM quay.io/ukhomeofficedigital/ileap-java11:0.1.1 as builder
ARG ART_USERNAME
ARG ART_PASSWORD

ENV ARTIFACTORY_USERNAME=${ART_USERNAME} \
    ARTIFACTORY_PASSWORD=${ART_PASSWORD}

ENV MVN_VERSION 3.8.1

# Install Maven
RUN apk add git
RUN mkdir -p $HOME/.m2/ && \
    wget https://apache.mirrors.nublue.co.uk/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz && \
    tar xvzf apache-maven-${MVN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MVN_VERSION} /var/local/ && \
    rm -- apache-maven-${MVN_VERSION}-bin.tar.gz && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnyjp /usr/local/bin/mvnyjp && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvnDebug /usr/local/bin/mvnDebug && \
    ln -s /var/local/apache-maven-${MVN_VERSION}/bin/mvn /usr/local/bin/mvn

COPY settings.xml $HOME/.m2/

ENTRYPOINT ["/bin/ash", "-c"]

CMD ["mvn -v"]
