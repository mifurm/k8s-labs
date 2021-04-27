<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Working with Docker registry

## LAB Overview

#### In this lab you will create your own private docker registry in Microsoft Azure. You will push an image there and run as a container using Azure Container Instances

## Task 1: Create Azure Container Registry
1. Login to Azure portal: `https://portal.azure.com`
2. Click **Create a resource** button
3. Search for **Container Registry** service, click **Create**
4. Fill the form:
   - **Registry name:** choose your name
   - **Resource group:** use your own resource group
   - **Location:** West Europe
   - **Admin user:** enable
   - **SKU:** Basic
5. Click **Create** and wait for the deployment to finish

## Task 2: Push an image into your registry
1. Go to "files" directory.
2. Build an image locally: `docker build -t myimage .`
3. Login to your registry: `docker login {registry_name}.azurecr.io`
4. Tag an image, point to remote registry: `docker tag myimage {registry_name}.azurecr.io/myimage`
5. Push the image: `docker push {registry_name}.azurecr.io/myimage`

## Task 3: Run a container using Azure Container Instances
1. Go back to Azure portal
2. Select your newly created registry service
3. From left menu select **Access Keys**
4. Save value of fields:
   - Login server
   - Username
   - password
5. Click **Create a resource** button
6. Search for **Container Instances** and click **Create**
7. Fill the form:
   - **Resource group:** use your own resource group
   - **Container name:** choose a name
   - **Region:** West Europe
   - **Image Type:** private
   - **Image name:** {registry_name}.azurecr.io/myimage
   - **Image registry login server:** use value copied in point 4
   - **Image registry user name:** use value copied in point 4
   - **Image registry password:** use value copied in point 4
   - **OS type:** Linux
   - **Size***: leave default 
8. After the deployment is completed go to newly created Container Instance and copy the IP address.
9. Past it into the browser and check that you apache2 in your container is running.