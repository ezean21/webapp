FROM python:3.8.3-slim-buster

RUN apt-get update && apt-get install -y iputils-ping net-tools telnet curl

ADD flask-socketio-chat /root/flask-socketio-chat

WORKDIR /root/flask-socketio-chat

RUN pip install -r requirements.txt

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
