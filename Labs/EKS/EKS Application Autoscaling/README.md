<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Pod's resources management

## LAB Overview

#### In this lab you will autoscale both your deplouments and your cluster

## Task 1: Installing metrics server
1. Deploy the Metrics Server with the following command:
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
```
2. Verify that the metrics-server deployment is running
```
kubectl get deployment metrics-server -n kube-system
```

## Task 2: Application autoscaling

1. Deploy the application using the following command:
```
kubectl apply -f files/1_deployment.yaml
```

2. Create a Horizontal Pod Autoscale
```
kubectl autoscale deployment httpd --cpu-percent=50 --min=1 --max=10
```
3. Look into sutoscaler 
```
kubectl describe hpa httpd
```
4. Create a load for the web server
```
kubectl run apache-bench -it --rm --image=httpd --restart=Never -- ab -n 500000 -c 1000 http://httpd.default.svc.cluster.local/
```
5. Watch the httpd deployment scale out:
```
kubectl get hpa httpd
```
6. Describe hpa and look into events
```
kubectl describe hpa httpd
```
7. When the load finishes, the deployment should scale back down to 1.

```
kubectl get rs -w
```

## Task 3: Cleanup
1. Delete the hpa and the deployment:
```
kubectl delete hpa httpd
kubectl delete deploy httpd
```
## END LAB

<br><br>


<center><p>&copy; 2019 Chmurowisko Sp. z o.o.<p></center>
