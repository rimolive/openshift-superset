FROM centos:latest
#radanalyticsio/openshift-spark
#openshift/python-27-centos7
# radanalyticsio/openshift-spark
#
MAINTAINER Zak Hassan <zak.hassan1010@gmail.com>
USER root

#RUN  virtualenv venv && source ./venv/bin/activate

RUN yum upgrade -y python-setuptools
RUN yum install -y gcc gcc-c++ libffi-devel python-devel python-pip \
  python-wheel openssl-devel libsasl2-devel openldap-devel --nogpgcheck
RUN curl https://bootstrap.pypa.io/get-pip.py | python -
#RUN pip install --upgrade pip
RUN pip install --default-timeout=1000  --no-cache-dir   superset

RUN fabmanager create-admin --app superset \
  --username admin \
  --firstname admin \
  --lastname admin \
  --email admin@admin.com \
  --password admin

RUN superset db upgrade && \
superset load_examples && \
superset init

EXPOSE 8088
# Start the web server on port 8088, use -p to bind to another port
CMD ["superset","runserver"]
