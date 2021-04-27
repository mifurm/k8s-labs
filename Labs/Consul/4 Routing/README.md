kubectl port-forward service/hashicorp-consul-server 8500:8500

kubectl apply -f 1_deployment.yaml
consul config write  2_service_defults.hsl
kubectl apply -f 3_client.yaml

kubectl exec client -it -- sh

for i in 1 2 3 4 5 6 7 8 9 ;do curl 127.0.0.1:5000; echo; done

consul config write 4_resolver.hsl

for i in 1 2 3 4 5 6 7 8 9 ;do curl 127.0.0.1:5000; echo; done


consul config delete -name application -kind service-resolver

consul write config 5_router.hsl

curl 127.0.0.1:5000
curl -H 'x-beta: 1' 127.0.0.1:5000


for i in 1 2 3 4 5 6 7 8 9 ;do curl 127.0.0.1:5000; echo; done

consul config delete -name application -kind service-router

consul write config 6_splitter.hsl


consul config delete -name application -kind service-splitter
consul config delete -name application -kind service-router
consul config delete -name application -kind service-defaults