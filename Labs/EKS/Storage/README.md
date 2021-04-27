```
kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"
```
```
aws eks describe-cluster --name cluster_name --query "cluster.resourcesVpcConfig.vpcId" --output text
```
aws eks describe-cluster --name test-fargate --query "cluster.resourcesVpcConfig.vpcId" --output text
```
aws ec2 describe-vpcs --vpc-ids vpc-exampledb76d3e813 --query "Vpcs[].CidrBlock" --output text
```
aws ec2 describe-vpcs --vpc-ids vpc-08b71eaec44870e29 --query "Vpcs[].CidrBlock" --output text
vpc-08b71eaec44870e29

CIDR=$(aws eks describe-cluster --name test-fargate --query "cluster.resourcesVpcConfig.vpcId" --output text)
aws ec2 describe-vpcs --vpc-ids $CIDR --query "Vpcs[].CidrBlock" --output text