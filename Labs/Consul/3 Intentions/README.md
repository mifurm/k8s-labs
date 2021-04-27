<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Working with intentions

## LAB Overview

#### In this lab you will work with sevices and intentions

## Task 1: Deploying a service

1. Create a deployment using following command:
```
kubectl apply -f deployment.yaml
```
2. Now you have 3 pods working as a service and one additional pod for debugging. Execute
```
kubectl get pods -l task=consul
```

## Task 2: Testing connections and adding an intention

1. Connect to the *nettools* pod using:
```
kubectl exec nettools -it -c tools -- sh
```
2. Check local environmental viariables
```
env
```
You should see lots of envs.
3. Look for envs describing your service 
```
env | grep SRV1
```
4. Try connecting to the service several times using:
```
curl 127.0.0.1:5000
```
You should get different resnponses. Consul loada balances your requests to all pods.
5. Using second terminal create a proxy connection to your consul server using following command
```
kubectl port-forward service/hashicorp-consul-server 8500:8500
```
6. Using any browser nagigate to *localhost:8500*
7. Click on **Intentions**
8. We want to block traffic from *tools* service to *srv1* service. Click **Create*.
9. From the **Source service** dropdown select *tools*.
10. From the **Destination service** dropdown select *srv1*.
11. Click **Save**.
12. Go back to your previous terminal (with connection to nettools pod opened).
13. Inside the pod execute:
```
curl 127.0.0.1:5000
```
Now te connection is forbidden and you should get following response ``curl: (52) Empty reply from server``
14. Exit the pod
``
exit
``

## Task 3. Removing the Intention

1. Look for your consul client pods by executing:
```
kubectl get pods -l component=client
```
2. Select one and execute:
```
kubectl exec CLIENT-POD-NAME -it -- sh
```
3. Inside the pod, using *Consul* client check if the connection between our services is denied or not.
```
consul intention check tools srv1
```
It should be *Denied* for now.
4. Remove the Intention by executing
```
consul intention delete tools srv1
```
5. Check if the connections are allowed
```
consul intention check tools srv1
```
6. Exit the pod
```
exit
```
7. Connect to your nettools pod
```
kubectl exec nettools -it -c tools -- sh
```
8. Check if the requests sent from tools to service are allowed
```
curl 127.0.0.1:500
```
## END LAB
9. Exit the pod
10. Clean up by executing
```
kubectl delete -f deployment.yaml
```
<br><br>

<center><p>&copy; 2019 Chmurowisko Sp. z o.o.<p></center>
