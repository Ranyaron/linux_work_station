FROM ubuntu

RUN apt update
RUN apt install python3-pip -y
RUN pip3 install django
RUN pip3 install pytz

RUN mkdir /app

ADD mydjangoapp.tar.xz /app/
RUN cd /app/mydjangoapp

CMD python3 /app/mydjangoapp/manage.py runserver 0.0.0.0:8000
