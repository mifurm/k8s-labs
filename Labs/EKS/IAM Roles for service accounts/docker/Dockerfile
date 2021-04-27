FROM python:alpine

ENV AWSCLI_VERSION "1.18.68"

RUN pip install --no-cache-dir awscli==$AWSCLI_VERSION
WORKDIR /aws
CMD sh