FROM centos:latest

MAINTAINER James Eckersall <james.eckersall@gmail.com>

RUN \
  yum install -y epel-release centos-release-scl centos-release-scl-rh && \
  rpm -Uvh https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm && \
  rpm -ivh https://download.pydio.com/pub/linux/centos/7/pydio-release-1-1.el7.centos.noarch.rpm && \
  yum -y install httpd && \
  yum -y install pydio-all

RUN \
  wget https://github.com/moxiecode/plupload/archive/v2.1.8.zip -O /tmp/plupload.zip && \
  unzip /tmp/plupload.zip -d /tmp/ && \
  mv /tmp/plupload-2.1.8/js /usr/share/pydio/plugins/uploader.plupload/plupload && \
  rm -rf /tmp/plupload-2.1.8 /tmp/plupload.zip && \
  sed -i -e 's/^RewriteBase.*$/RewriteBase \//g' /usr/share/pydio/.htaccess && \
  sed -i -e 's/Listen 80/Listen 8080/g' /opt/rh/httpd24/root/etc/httpd/conf/httpd.conf

COPY run.sh /
RUN chmod 0755 /run.sh
COPY pydio.conf /opt/rh/httpd24/root/etc/httpd/conf.d/pydio.conf

ENV MAX_UPLOAD 1024M

EXPOSE 8080
ENTRYPOINT '/run.sh'
