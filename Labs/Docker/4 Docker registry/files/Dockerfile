FROM ubuntu:latest

RUN apt update && apt install -y apache2

RUN mkdir /var/www/html/mypage
COPY index.html /var/www/html/mypage

EXPOSE 80

CMD apachectl -k start -X # this command starts apache2 in no detached mode