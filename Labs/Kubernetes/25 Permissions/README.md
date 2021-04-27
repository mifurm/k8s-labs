<img src="../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Permissions

## LAB Overview

## Task 1: 

1. 

```
kubectl create ns web
./adduser.sh web-user
kubectl apply -f 1_role.yaml
```
New user:
```
kubectl get svc
kubectl get pods -n web
```
2. 
```
kubectl apply -f 2_curl.yaml
```
```
kubectl exec curl-with-proxy -it -c main -- sh
```

Inside the container
```
curl  http://localhost:8001/
curl  http://localhost:8001/api/v1/namespaces/web/pods
exit
```
kubectl delete ns web

3. 
```
kubectl apply -f 3_curl_cluster.yaml 
kubectl exec curl-with-proxy -it -c main -- sh
```

Inside the container
```
curl  http://localhost:8001
curl  http://localhost:8001/api/v1/nodes
exit
```
```
kubectl delete -f 3_curl_cluster.yaml 
```


## END LAB

<br><br>

<center><p>&copy; 2020 Chmurowisko Sp. z o.o.<p></center>
