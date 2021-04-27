<img src="../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Configurations

## LAB Overview

## Task 1: Configmaps

1. 
```
kubectl apply -f 1_env.yaml
kubectl logs env
kubectl delete -f 1_env.yaml
```
2. 
```
kubectl create cm configmap --from-literal=var1=25 --from-literal=var2="text value"
kubectl apply -f 2_env_cm.yaml
kubectl logs env-from-configmap
kubectl delete -f 2_env_cm.yaml

```
3. 
```
kubectl apply -f 3_env_cm.yaml
kubectl logs env-from-configmap
kubectl delete -f 3_env_cm.yaml
```
4. 
```
kubectl apply -f 4_env_cm.yaml
kubectl logs env-from-configmap
kubectl delete -f 4_env_cm.yaml
```


5. 
```
kubectl create cm configmap-file --from-file=config-file.conf
kubectl get cm configmap-file -o yaml
kubectl apply -f 5_file_cm.yaml
kubectl logs configmap-volume
kubectl exec configmap-volume -it -- sh
```
Inside the container
```
cat /etc/myconf/config-file.conf
exit
```

6. 
```
kubectl edit cm configmap-file
```

```
kubectl exec configmap-volume -it -- sh 
```
Inside the container
```
cat /etc/myconf/config-file.conf
exit
```


```
kubectl delete -f 5_file_cm.yaml
kubectl delete cm configmap configmap-file
```

## Task 2: Secrets

1. 
```
kubectl get secrets
kubectl describe secrets
```

2. 
```
kubectl run secret --image=alpine --restart=Never -- /bin/sh -c 'sleep 3600'
kubectl describe pod secret
```
 Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-vz4tq (ro)
```
kubectl exec secret ls /var/run/secrets/kubernetes.io/serviceaccount
kubectl delete pod secret --force --grace-period=0
```
3. 
```
kubectl create secret generic mysecret --from-file=secret
kubectl get secret mysecret -o yaml
```

```
kubectl apply -f 6_secret_file.yaml
kubectl exec secret ls /var/secret
kubectl exec secret cat /var/secret/secret
kubectl delete -f 6_secret_file.yaml
kubectl delete secret mysecret
```

```
kubectl create secret generic mysecret --from-literal=key1=val1
kubectl apply -f 7_secret_env.yaml
kubectl exec secret env
kubectl delete -f 7_secret_env.yaml
```


## Task 3: Pod metadata (Downward API)

1. 
```
kubectl apply -f 8_downward_api_env.yaml
kubectl exec downward env
kubectl delete -f 8_downward_api_env.yaml
```
2. 
```
kubectl apply -f 9_downward_api_file.yaml 
kubectl exec downward cat /etc/downward/labels
kubectl exec downward cat /etc/downward/annotations
kubectl exec downward ls /etc/downward
kubectl exec downward cat /etc/downward/podName
```

## Task 4: API Server

1. 
```
kubectl cluster-info
```
```
curl -k kubernetesmaster
```
Unauthorized

```
kubectl proxy
curl localhost:8001
curl localhost:8001/api/v1/nodes
curl localhost:8001/api/v1
```

```
kubectl run test --image=alpine --restart=Never -- /bin/sh -c 'sleep 3600'
curl localhost:8001/api/v1/namespaces/default/pods/
kubectl delete pod test --force --grace-period=0
```

2. 
```
kubectl run curl --image=tutum/curl --restart=Never  -- /bin/sh -c 'sleep 99999'
kubectl exec -it curl bash
```
Inside the container
```
env | grep KUBERNETES_SERVICE
curl https://kubernetes
curl https://kubernetes -k
```
```
ls /var/run/secrets/kubernetes.io/serviceaccount/
curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt https://kubernetes
export CURL_CA_BUNDLE=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
curl https://kubernetes
```

```
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
curl -H "Authorization: Bearer $TOKEN" https://kubernetes
exit
```

If you’re using a Kubernetes cluster with RBAC enabled, the service account may not be authorized to access (parts of) the API server. You’ll learn about service accounts and RBAC in chapter 12. For now, the simplest way to allow you to query the API server is to work around RBAC by running the following command:
```
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --group=system:serviceaccounts
```
This gives all service accounts (we could also say all pods) cluster-admin privileges, allowing them to do whatever they want. Obviously, doing this is dangerous and should never be done on production clusters. For test purposes, it’s fine.
```
kubectl exec -it curl bash
```
Inside the container
```
curl -H "Authorization: Bearer $TOKEN" https://kubernetes
```
Listing pods in the pod's own namespace
```
NS=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
curl -H "Authorization: Bearer $TOKEN" https://kubernetes/api/v1/namespaces/$NS/pods
exit
```
``
kubectl delete pod curl --force --grace-period=0
``

## Task 5: API Server using ambassador container

1. 
```
kubectl apply -f 10_curl_ambassador.yaml 
kubectl exec -it curl-with-ambassador -c main bash
```
Inside the container:
```
curl localhost:8001
exit
```
```
kubectl delete -f 10_curl_ambassador.yaml 
```


## END LAB

<br><br>

<center><p>&copy; 2020 Chmurowisko Sp. z o.o.<p></center>
