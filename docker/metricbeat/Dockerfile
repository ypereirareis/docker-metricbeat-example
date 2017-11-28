FROM docker.elastic.co/beats/metricbeat:6.0.0

COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
USER root
RUN mkdir /var/log/mybeat
RUN chown metricbeat /usr/share/metricbeat/metricbeat.yml
RUN chmod go-w /usr/share/metricbeat/metricbeat.yml
RUN chown metricbeat /var/log/mybeat
USER metricbeat