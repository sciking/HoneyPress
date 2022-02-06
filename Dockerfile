FROM ubuntu
MAINTAINER dustyfresh, https://github.com/dustyfresh
RUN apt-get update && apt-get install --yes vim build-essential python-setuptools python3-pip supervisor curl
RUN pip3 install flask
RUN mkdir -pv /opt/honeypress/logs
ADD src/templates /opt/honeypress/templates
ADD src/config.py /opt/honeypress/config.py
ADD src/honeypress.py /opt/honeypress/honeypress.py
ADD src/requirements.txt /opt/honeypress/requirements.txt
RUN pip3 install -r /opt/honeypress/requirements.txt && chmod +x /opt/honeypress/honeypress.py
RUN touch /opt/honeypress/logs/auth.log /opt/honeypress/logs/access.log /opt/honeypress/logs/mobiledetector.log
ADD conf/supervise-honeypress.conf /etc/supervisor/conf.d/supervise-honeypress.conf
CMD ["/usr/bin/supervisord", "-n"]
