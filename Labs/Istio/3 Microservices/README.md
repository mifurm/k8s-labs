<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Installing microservices

## LAB Overview

#### In this lab you will perform a deployment od microservices to the cluster

![application](img/app_components.png)

## Task 1: Creating a namespace for the deployment
1. Execute following command to create a namespace for the deployment
```
kubectl create namespace srv
```
2. The default Istio installation uses automatic sidecar injection. Label the namespace that will host the application with istio-injection=enabled:
```
kubectl label namespace srv istio-injection=enabled
```

## Task 2: Deploying the appliacaion
1. Download [a manifest file](files/k8s/deployments.yaml).
2. Deploy the file by executing:
```
kubectl apply -f deployments.yaml
```
Using the deployments file you created:
* 3 service accounts
* 3 devloyments
* 3 virtual services
* ingres for all services

## Task 3: Examinig the solution
1. Verify that all services are up and running by executong following command:
```
kubectl get svc -n srv
```
You should have 3 service running
![services](img/app_services.png)

2. Verify that istio proxy was injected to all the pods:
```
kubectl get pods -n srv
```
![pods](img/app_pods.png)


3. Determine the ingress IP by executing the following command:
```
kubectl get svc --all-namespaces
```
and find the external IP for your ingress
![ingress](img/ingress_ip.png)
<br><br>

4. Open any browser of your choice and open following urls:
* ``<YOUR-INGRESS-IP>/app1``
* ``<YOUR-INGRESS-IP>/srv1``
* ``<YOUR-INGRESS-IP>/srv2``

All pages should be accessible.

if you have *istioctl* installed on your computer:

5. Using *bash* execute following command
```
for  ((i=1;i<=100;i++)); do   curl  "<YOUR-INGRESS-IP>/app1"; done
```

6. Open *kiali* by executing:
```
istioctl dashboard kiali
```
and look into it.
7. Open **Display** menu and turn on **Traffic animation**.
8. Execute the following command once again and watch the animation :-)
```
for  ((i=1;i<=100;i++)); do   curl  "<YOUR-INGRESS-IP>/app1"; done
```

## END LAB

<br><br>
<center><p>&copy; 2019 Chmurowisko Sp. z o.o.<p></center>
