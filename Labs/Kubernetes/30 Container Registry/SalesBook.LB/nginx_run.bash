docker build . -t nginx-sample
docker run --name nginx-sample -d -p 8000:80 nginx-sample