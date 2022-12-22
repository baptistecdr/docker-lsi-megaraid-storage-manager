FROM eclipse-temurin:8u345-b01-jre@sha256:5055cc1a67a9ade6efd948a3181a3c8f2af6943a3750cc880f7d34b5c1ab1df9 AS builder

FROM rockylinux:9.1@sha256:8eb38f164ff94b7e033f6da6c063dabfb7f32f7c179dc7d69cc4ce636cd33355

ENV JAVA_HOME /opt/java/openjdk
ENV JRE_HOME /opt/java/openjdk
ENV PATH /opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV removesnmp "1"
ENV ROOT_PASSWORD "password"

WORKDIR /
COPY root /
COPY --from=builder /opt/java/openjdk /opt/java/openjdk

RUN yum -y update && yum install -y passwd procps firefox unzip && yum clean all

RUN mkdir "MSM_linux_x64_installer"
RUN tar -C /MSM_linux_x64_installer -xzvf MSM_linux_x64_installer-17.05.06-00.tar.gz && \
    rm -f /MSM_linux_x64_installer-17.05.06-00.tar.gz
WORKDIR /MSM_linux_x64_installer/disk
# Fix ./deleteOldVersion.sh: line 20: [: =: unary operator expected
RUN sed -i 's/ $upgradesetuptype / "$upgradesetuptype" /g' deleteOldVersion.sh
RUN ./RunRPM.sh

ENTRYPOINT ["/entrypoint.sh"]
