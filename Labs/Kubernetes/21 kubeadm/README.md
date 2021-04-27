<img src="../img/logo.png" alt="Chmurowisko logo" width="200" align="right">
<br><br>
<br><br>
<br><br>

# Build the  Cluster using *kubeadm*

## LAB Overview


You will need 3 virtual machines with Ubuntu 16.0, and minimal 2 vCPU. 

#### In this lab you will confiure yor own kuberntes cluster

## Task 1: Install Docker and kubernetes

### Do this on all your machines

1. First set up the Docker and Kubernetes repositories: 
```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list 
deb https://apt.kubernetes.io/ kubernetes-xenial main 
EOF
```

2. Then Install Docker and Kubernetes packages: 
```shell
sudo apt-get update

sudo apt-get install -y docker-ce=18.06.3~ce~3-0~ubuntu kubelet=1.17.3-00 kubeadm=1.17.3-00 kubectl=1.17.3-00

sudo apt-mark hold docker-ce kubelet kubeadm kubectl
```

3. Enable iptables bridge call:
```shell
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf sudo sysctl -p

sudo sysctl -p
```

## Configure Master 

### Select one VM and run this comands only on this. This will be our master

1. To Initialize the cluster type: 
```shell
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```


And the end you will see in terminal command like this copy it, and save we will be use it later 

~~~
kubeadm join $controller_private_ip:6443 --token $token --discovery-token-ca-cert-hash $hash
~~~


2. Next we set up local kubeconfig by type: 
```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

3. Install Flannel networking
```shell
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/3f7d3e6c24f641e7ff557ebcea1136fdf4b1b6a1/Documentation/kube-flannel.yml
```

## Connect workers to cluster 
### Do this for rest servers (not for maser)

1. Join the node to the cluster:

Add **sudo** to comand which you copy and run it 
```shell
sudo kubeadm join $controller_private_ip:6443 --token $token --discovery-token-ca-cert-hash $hash
```

## Test
## Do this only on maser 

1. Verify that all nodes are joined and ready:
```shell
kubectl get nodes
```
You should see all three servers with a status of Ready


```
NAME               STATUS   ROLES    AGE   VERSION
ip-172-31-23-16    Ready    <none>   95s   v1.17.3
ip-172-31-27-114   Ready    master   11m   v1.17.3
ip-172-31-27-140   Ready    <none>   59s   v1.17.3
```
## END LAB

<br><br>

<center><p>&copy; 2020 Chmurowisko Sp. z o.o.<p></center>
