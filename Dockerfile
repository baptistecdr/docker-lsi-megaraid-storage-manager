FROM rockylinux:8.5

ENV JRE_HOME /usr/lib/jvm/adoptopenjdk-8-hotspot-jre
ENV removesnmp "1"
ENV ROOT_PASSWORD "password"

WORKDIR /
COPY root /

RUN yum -y update && yum clean all
RUN yum -y install passwd firefox adoptopenjdk-8-hotspot-jre unzip

RUN mkdir "MSM_linux_x64_installer"
RUN tar -C /MSM_linux_x64_installer -xzvf MSM_linux_x64_installer-17.05.06-00.tar.gz && \
    rm -f /MSM_linux_x64_installer-17.05.06-00.tar.gz
WORKDIR /MSM_linux_x64_installer/disk
# Fix ./deleteOldVersion.sh: line 20: [: =: unary operator expected
RUN sed -i 's/ $upgradesetuptype / "$upgradesetuptype" /g' deleteOldVersion.sh
RUN ./RunRPM.sh

ENTRYPOINT ["/entrypoint.sh"]
