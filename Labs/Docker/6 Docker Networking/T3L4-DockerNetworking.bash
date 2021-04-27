
#show all networks
docker network ls

#create new networks
docker network inspect frontendnet
docker network inspect backendnet

#create containers and connect them to network
docker run -it --name csdockerub01 --network frontendnet alpine sh
docker run -it --name csdockerub02 --network backendnet alpine sh
docker run -it --name csdockerub03 --network backendnet alpine sh
docker run -it --name csdockerub04 --network frontendnet alpine sh

#create network with subnet and gateway
docker network create --subnet 10.2.0.0/24 --gateway 10.2.0.1 networkwithsb
docker run -it --name csdockerub04 --network br02 networkwithsb sh

#connect container to host
docker run -it --network host alpine sh