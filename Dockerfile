FROM eclipse-temurin:8u342-b07-jre@sha256:63a28bcd8dc25d11266ebdbe354049850d21542476810a62fd1a8ad0b51e987d AS builder

FROM rockylinux:9.0@sha256:589b293b63aa244aba2fdd20614b11cbe9905f94f657d7c62e7fcad8bffbb37a

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
