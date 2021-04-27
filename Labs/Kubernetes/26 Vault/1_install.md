```
git clone https://github.com/hashicorp/vault-helm.git
```

```
helm install vault -f values.yaml
```

```
kubectl exec -ti vault-0 -- vault operator init
```
# NIE ZAPOMNIJ zapisać informacji które powyższa komenda zwróci! 

# Użyj 3 tokenów do "odpieczętowania" vaulta komendą

vault operator unseal

# Eksport zmiennych na twoim kliencie

```
export VAULT_ADDR=http://adres serwera
export VAULT_TOKEN=<ROOT_TOKEN_GENERATED_DURING_INIT>
```

```
vault login
```