FROM jameseckersall/docker-centos-base

MAINTAINER James Eckersall <james.eckersall@gmail.com>

RUN rpm -ivh https://download.pydio.com/pub/linux/centos/7/pydio-release-1-1.el7.centos.noarch.rpm && \
    yum -y install httpd && \
    yum -y install pydio-all

RUN wget https://github.com/moxiecode/plupload/archive/v2.1.8.zip -O /tmp/plupload.zip && \
    unzip /tmp/plupload.zip -d /tmp/ && \
    mv /tmp/plupload-2.1.8/js /usr/share/pydio/plugins/uploader.plupload/plupload && \
    rm -rf /tmp/plupload-2.1.8 /tmp/plupload.zip

COPY supervisord.d/ /etc/supervisord.d/
COPY hooks/ /hooks/

ENV MAX_UPLOAD 1024M

EXPOSE 80
