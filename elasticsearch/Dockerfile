FROM elasticsearch:latest

MAINTAINER Bo-Yi Wu <appleboy.tw@gmail.com>

EXPOSE 9200 9300

#RUN apt-get update && \
#  apt-get install -y --no-install-recommands wget unzip && \
#  wget -c "https://github.com/medcl/elasticsearch-analysis-ik/archive/master.zip" && \
#  unzip master.zip && \

# Add x-pack plugin
RUN bin/elasticsearch-plugin install x-pack --batch

# Add ICU analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html>
RUN bin/elasticsearch-plugin install analysis-icu

# Add Chinese analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html>
RUN bin/elasticsearch-plugin install analysis-smartcn

# Add Japanese (kuromoji) analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html>
RUN bin/elasticsearch-plugin install analysis-kuromoji

# Add phonetic analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html#analysis-phonetic-install>
RUN bin/elasticsearch-plugin install analysis-phonetic

#RUN bin/elasticsearch-plugin install discovery-multicast

#RUN bin/elasticsearch-plugin install analysis-stempel

#RUN bin/elasticsearch-plugin install analysis-ukrainian

#RUN bin/elasticsearch-plugin install discovery-file

#RUN bin/elasticsearch-plugin install ingest-attachment

#RUN bin/elasticsearch-plugin install ingest-geoip

#RUN bin/elasticsearch-plugin install ingest-user-agent

#RUN bin/elasticsearch-plugin install mapper-attachments

#RUN bin/elasticsearch-plugin install mapper-size

#RUN bin/elasticsearch-plugin install mapper-murmur3

#RUN bin/elasticsearch-plugin install lang-javascript

#RUN bin/elasticsearch-plugin install lang-python

#RUN  bin/elasticsearch-plugin install repository-hdfs

#RUN bin/elasticsearch-plugin install repository-s3

#RUN bin/elasticsearch-plugin install repository-azure

#RUN bin/elasticsearch-plugin install repository-gcs

#RUN bin/elasticsearch-plugin install store-smb

#RUN bin/elasticsearch-plugin install discovery-ec2

#RUN bin/elasticsearch-plugin install discovery-azure-classic

#RUN bin/elasticsearch-plugin install discovery-gce


######################################
# install Chinese ik analyzer 
# <http://www.cnblogs.com/hunttown/p/5450635.html>
######################################

#COPY analysis-ik /usr/share/elasticsearch/plugins
#COPY extend.yml /tmp
#COPY config /tmp/config

#RUN apt-get update \
#  && apt-get install -y --no-install-recommends wget unzip maven openjdk-8-jdk
#RUN cd /tmp \
#  && wget -c https://github.com/medcl/elasticsearch-analysis-ik/archive/master.zip \
#  && unzip master.zip
 
#RUN cd /tmp/elasticsearch-analysis-ik-master \
#  && mvn package

#RUN unzip /tmp/elasticsearch-analysis-ik-master/target/releases/elasticsearch-analysis-ik-5.2.2.zip -d /usr/share/elasticsearch/plugins/ik

#RUN cat /tmp/extend.yml >> /usr/share/elasticsearch/config/elasticsearch.yml
#RUN cp /usr/share/elasticsearch/plugins/ik/http*.jar /usr/share/elasticsearch/lib

#RUN cp -rf /tmp/config/* /usr/share/elasticsearch/plugins/ik/config/

####################################
# clean cache and tmp files
####################################

#RUN apt-get clean \
  #&& apt-get remove --purge -y wget unzip maven openjdk-8-jdk \
#  && rm -rf /tmp/* /var/tmp/*

