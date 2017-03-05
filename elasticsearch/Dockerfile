FROM elasticsearch:latest

MAINTAINER Bo-Yi Wu <appleboy.tw@gmail.com>

EXPOSE 9200 9300

#RUN apt-get update && \
#  apt-get install -y --no-install-recommands wget unzip && \
#  wget -c "https://github.com/medcl/elasticsearch-analysis-ik/archive/master.zip" && \
#  unzip master.zip && \


# Add ICU analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html>
RUN bin/elasticsearch-plugin install analysis-icu

# Add Chinese analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html>
RUN bin/elasticsearch-plugin install analysis-smartcn
