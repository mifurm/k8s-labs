<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Pod's resources management

## LAB Overview

#### In this lab you will enable IAM roles for service accounts

## Task 1: Creating an aws-cli pod
1. Create the Kubernetes service account by executing:
```
kubectl create sa sa-s3
```
2. Execute the following command to create an aws-cli pod
```
kubectl apply -f files/cli_pod.yaml
```
3. Check if the pod is working well. Enter the pod by executing:
```
kubectl exec aws-cli -it -- sh
```
4. Inside the pod execute:
```
aws --version
```
5. Still inside the pod, check if the pod has S# permissions by executing:
```
aws s3 ls
```
Tou should get an error *An error occurred (AccessDenied) when calling the ListBuckets operation: Access Denied*
6. Exit the pod and terminate it by executing:
```
kubectl delete -f files/cli_pod.yaml --force --grace-period=0
```

## Task 2: Checking if roles are already enabled 

1. Get the list of your clusters:
```
aws eks list-clusters --output table
```
2. Choose the cluster and execute
```
aws eks describe-cluster --name cluster_name --query "cluster.identity.oidc.issuer" --output text
```
3. If there is no endpoint returned in step 2 execute:
```
eksctl utils associate-iam-oidc-provider --cluster cluster_name --approve
```

## Task 3: Creating the policy and the role for service account
1. Execute following command to create a policy:
```
aws iam create-policy --policy-name eks-policy --policy-document file://files/policy.json
```
Note the ARN of the policy
2. Execute 
```
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text) 
OIDC_PROVIDER=$(aws eks describe-cluster --name cluster-name --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")
``` 
to get Account Id and oidc provider inside your environment.
3. Echo the values by executing:
```
echo $OIDC_PROVIDER
echo $AWS_ACCOUNT_ID
```
3. Edit [assume policy file](files/assume_policy.json). Replace placeholders:
* AWS_ACCOUNT_ID
* OIDC_PROVIDER
* namespace
* service-account-name
with your values.
4. Replace IAM_ROLE_NAME with your name and create the role:
```
aws iam create-role --role-name IAM_ROLE_NAME --assume-role-policy-document file://assume_policy.json --description "A role for Kubernetes service account"
```
4. If you do not have the ARN of your S3 policy execute:
```
aws iam list-policies | grep eks-policy
```
5. Attach your S3 policy by executing:
```
aws iam attach-role-policy --role-name IAM_ROLE_NAME --policy-arn=IAM_POLICY_ARN
aws iam attach-role-policy --role-name k8s-s3-role --policy-arn=arn:aws:iam::655379451354:policy/eks-policy
```

## Task 4: Attaching the role to service account
1. Edit [service account manifest](files/service_account.yaml)
2. Configure the service account by executing:
```
kubectl apply -f files/service_account.yaml 
```

## Task 5: Testing
1. Create the pod again:
```
kubectl apply -f files/cli_pod.yaml
```
2. Enter the pod by executing:
```
kubectl exec aws-cli -it -- sh
```
4. Inside the pod execute:
```
aws s3 ls
```
## END LAB

<br><br>


<center><p>&copy; 2019 Chmurowisko Sp. z o.o.<p></center>
