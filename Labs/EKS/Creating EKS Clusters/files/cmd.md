```
aws eks --region region-code update-kubeconfig --name cluster_name
```

## creating cluster - Example
```
eksctl create cluster \
--name eks1 \
--version 1.16 \
--nodegroup-name standard-workers \
--node-type t2.medium \
--nodes 1 \
--nodes-min 1 \
--nodes-max 1 \
--node-ami auto \
--vpc-nat-mode Disable \
--region eu-west-1
```
## Creating Fargate cluster
```
eksctl create cluster -f fargate.yaml
```
## Creating basic cluster
```
eksctl create cluster -f basic-cluster.yaml
```
## Updating cluster
### Updating control place
```
eksctl update cluster --name basic-cluster
eksctl update cluster --name basic-cluster --approve
```
### Adding new node group
```
eksctl create nodegroup -f nodegroup.yaml
```
### Deleting old node group
```
eksctl get nodegroups --cluster=basic-cluster
eksctl delete nodegroup --cluster=basic-cluster --name=ng-1
```

## Adding two spot node groups
eksctl create nodegroup -f spot-ng.yaml

## Adding managed node group
```
eksctl create nodegroup -f managed-ng.yaml
```

### Deleting node groups
```
eksctl get nodegroups --cluster=basic-cluster
eksctl delete nodegroup --cluster=basic-cluster --name=ng-1-1-16 
eksctl delete nodegroup --cluster=basic-cluster --name=managed-ng
eksctl delete nodegroup --cluster=basic-cluster --name=ng-spots-1
eksctl delete nodegroup --cluster=basic-cluster --name=ng-spots-2
```

## Adding 3 node groups
```
eksctl create nodegroup -f mixed-ng.yaml
```

## Adding autoscaler for spot node groups

* Edit node groups names before applying

```
kubectl apply -f autoscaler.yaml
```
[Amazon EKS-optimized Linux AMI](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html)

# Installing Calico
```
kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.6/config/v1.6/calico.yaml
```

kubectl -n kube-system edit deployment.apps/cluster-autoscaler