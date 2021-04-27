<img src="../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Network Policies

## LAB Overview

#### Service migration

## Task 1: Deploying the external service

1. Deploy the application
```
kubectl apply -f 1_predeployment.yaml
```
2. Find your *service*  address by executing:
```
kubectl get svc external-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}' -n external-service
```

## Task 2: Adding external service to our envorionent

1. Create a service by applying manifest file:
```
kubectl apply -f 2_service.yaml
```
2. Describe the service by:
```
kubectl describe svc my-super-service
```
Look into the result. There is no endpoint.
3. Create the endpoint:
```
kubectl apply -f 3_endpoint.yaml
```
4. Describe the service once again:
```
kubectl describe svc my-super-service
```
Now, there is our endpoint added
5. Run additional debuggind pod by executing:
```
kubectl run test --image=przemekmalak/tools --rm -it -- sh
```
6. Inside the debuggind pod check if there is a connection to the service
```
curl -m 3 my-super-service
```
7. You can also check existing endpoints by:
```
kubectl get endpoints
```

## Task 3. Deploy the service inside the cluster

1. Deploy the pods by executing
```
kubectl apply -f 4_deployment.yaml 
```
2. Describe the service:
```
kubectl describe svc my-super-service
```
3. Check the endpoints once again
```
kubectl get endpoints
```
Now my-super-service endpoints consist of interlan ip addresses of the pods.
4. Run additional debuggind pod once again by executing:
```
kubectl run test --image=przemekmalak/tools --rm -it -- sh
```
6. Inside the debuggind pod check if there is a connection to the service
```
for i in {1 2 3 4 5 6 7 8 9 };do curl my-super-service; echo; done
```
Now the traffic is distributed to your deployment

## Task 4: Cleanup
1. Remove the resources by executing:
```
kubectl delete -f .
```
## END LAB

<br><br>

<center><p>&copy; 2020 Chmurowisko Sp. z o.o.<p></center>
