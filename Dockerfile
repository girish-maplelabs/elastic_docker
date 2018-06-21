FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.4

RUN elasticsearch-plugin remove x-pack
RUN elasticsearch-plugin install x-pack


RUN mkdir /usr/share/elasticsearch/es_data

COPY config/elasticsearch.yml /usr/share/elasticsearch/config/

USER root
RUN chown  elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/es_data
USER elasticsearch

# Set environment
ENV DISCOVERY_SERVICE elasticsearch

# Kubernetes requires swap is turned off, so memory lock is redundant
ENV MEMORY_LOCK false

WORKDIR /usr/share/elasticsearch/

EXPOSE 9200
EXPOSE 9300

# Define default command.
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
