<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Working with Docker storage

## LAB Overview

#### In this lab you will work with docker volumes and bind mounts

## Task 1: Create a bind mount to local directory
1. Create local directory: `mkdir appfiles`
2. Create new file in the directory above: `touch appfiles/conf.properties`
3. Edit the file and add one line: `env=prod`
4. Run simple container with bind mount: `docker run -it --mount type=bind,source="$(pwd)"/appfiles/,target=/conf busybox:latest sh`
   
Note that "source" params's value must be absolute. Instead of using `$(pwd)` you can just enter your absolute path.

5. Inside the container execute: `cat /conf/conf.properties` and verify that the file exists.
6. Exit the container: `exit`

## Task 2: Create a volume and mount it to two containers
1. Create new volume: `docker volume create myvol`
2. Verify that the volume has been created: `docker volume ls`
3. Run new container with volume attached to it: `docker run -it --name volcon01 --mount source=myvol,target=/app busybox:latest sh`
4. Inside the container create new file: `touch /app/conf.properties`
5. Insert some content into the file: `echo "env=test" > /app/conf.properties`
6. Open new terminal (don't stop "volcon01" container) and run new container with same volume mounted: `docker run -it --name volcon02 --mount source=myvol,target=/app busybox:latest sh`
7. Verify that conf.properties file exists and contains your content: `cat /app/conf.properties`

## Clean-up:
1. Exit both containers
2. Remove both containers:
   
`docker rm volcon01`

`docker rm volcon02`

3. Remove the volume: `docker volume rm myvol`