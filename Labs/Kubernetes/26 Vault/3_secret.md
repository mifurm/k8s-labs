# create secret

vault kv put secret/helloworld username=hellovault password=P@ssw0rd123

vault kv get secret/helloworld

kubectl apply -f 1.yaml
kubectl exec PODNAME -- ls -l /vault/secrets




kubectl patch deploy debug --patch "$(cat patch1.yaml)"

kubectl exec POD_NAME -- ls -l /vault/secrets
kubectl exec POD_NAME -- cat /vault/secrets/helloworld

kubectl patch deploy debug --patch "$(cat patch2.yaml)"

kubectl exec POD_NAME -- ls -l /vault/secrets
kubectl exec POD_NAME -- cat /vault/secrets/helloworld