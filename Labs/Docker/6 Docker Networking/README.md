<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Working with Docker networks

## LAB Overview

#### In this lab you will work with different drivers of docker network

## Task 1: Use bridge driver network
1. Create new network with bridge driver: `docker network create mybridgenet01`
2. Run new container in newly created network: `docker run -it --network mybridgenet01 --name mycon01 busybox:latest sh`
3. Inside the container chech it's ip address: `ifconfig`
4. Run another container in the same network: `docker run -it --network mybridgenet01 --name mycon02 busybox:latest sh`
5. Check that you can ping the other container: `ping IP_ADDRESS`
6. Exit "mycon02" container
7. Run yet another container but use default network: `docker run -it --name mycon03 busybox:latest sh`
8. Check that you cannot ping the container which is in another network.
9. During network creation you can specify it's parameters. Create new network specyfing subnet and gateway: `docker network create --subnet 10.2.0.0/24 --gateway 10.2.0.1 networkwithsb`
10. Run new container inside this network: `docker run -it --rm --network networkwithsb busybox:latest sh`
11. Check that continer got and IP address from subnet's pool: `ifconfig`

## Task 2: Use the host network driver
1. Run new container with nginx: `docker run --name some-nginx -d -p 8080:80 nginx:latest`
2. Check if it is accessible from your host. Open browser and type: `http://localhost:8080`
3. Run simple container: `docker run -it --rm busybox:latest sh`
4. Check if you can connect to nginx using localhost: `wget localhost:8080`
5. Exit the container and run another one using "host" network driver: `docker run -it --rm --network host busybox:latest sh`. Now containers's network is shared with host's network.
6. Now check if you can connect: `wget localhost:8080`

## Task 3: Use the none network driver
1. Run a container with none network: `docker run -it --rm --network none busybox:latest sh`
2. Check that you cannot ping anything. (eg. `ping 8.8.8.8`). Your container is isolated.

## Clean-up:
1. Exit all containers
2. Remove all containers.
3. Remove networks created in this lab: `docker network rm NETWORK_ID`