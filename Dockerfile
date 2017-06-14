FROM ubuntu:14.04
MAINTAINER patton,zhaotj@huntor.cn
WORKDIR /
RUN set -x \
	&& apt-get update \
	&& apt-get install -yqq git tar unzip zip
COPY data-integration.tar.gz /root/
COPY jdk-8u101-linux-x64.tar.gz /root/
WORKDIR /root/
RUN set -x \
	&& pwd \
	&& tar -xvzf  data-integration.tar.gz \
	&& chmod +x data-integration/*.sh \
	&& rm -f data-integration.tar.gz \
	&& tar -xvzf jdk-8u101-linux-x64.tar.gz \
	&& rm -f jdk-8u101-linux-x64.tar.gz
COPY conf/.kettle /root/data-integration/.kettle
ENV JAVA_HOME /root/jdk1.8.0_101
ENV PATH $JAVA_HOME/bin:$PATH
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV KETTLE_HOME /root/data-integration
ENV PATH $KETTLE_HOME:$PATH
ENV TZ=Asia/Shanghai

WORKDIR /data/docker/bi/
RUN set -x \
#cp /data/docker/bi/profile ~/.profile \
#source ~/.profile
WORKDIR /
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN kitchen.sh
WORKDIR /
COPY shell/init.sh init.sh
RUN set -x \
	&& chmod +x init.sh
ENTRYPOINT ["/init.sh"]
