FROM radanalyticsio/openshift-spark
#openshift/python-27-centos7
# radanalyticsio/openshift-spark
#
MAINTAINER Zak Hassan <zak.hassan1010@gmail.com>
USER root

RUN yum install -y python2 python-pip python-devel gcc libsasl2-devel \
libldap2-devel openssl-devel 

#RUN pip3 install virtualenv && python -m venv test && source ./test/bin/activate
#python2 \
# gcc libffi-devel python-devel python-pip
#python2 python3 gcc
RUN curl https://bootstrap.pypa.io/get-pip.py | python -
#RUN pip install --upgrade pip
RUN pip install --default-timeout=1000  --no-cache-dir   superset==0.15.1

RUN /opt/app-root/bin/fabmanager create-admin --app superset \
  --username admin \
  --firstname admin \
  --lastname admin \
  --email admin@admin.com \
  --password admin

RUN /opt/app-root/bin/superset db upgrade && \
/opt/app-root/bin/superset load_examples && \
/opt/app-root/bin/superset init

EXPOSE 8088
# Start the web server on port 8088, use -p to bind to another port
CMD ["/opt/app-root/bin/superset","runserver"]
