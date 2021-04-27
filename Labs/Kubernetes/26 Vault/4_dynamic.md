Instalacja bazy

```
helm install mydb \
  --set postgresqlPassword=password,postgresqlDatabase=mydb \
  --set service.type=NodePort,service.nodePort=32543 \
    stable/postgresql
```
```
kubectl run -i --tty --rm debug --image=postgres:alpine --restart=Never -- sh
psql postgresql://postgres:password@mydb-postgresql
```

Włączenie silnika obsługi baz danych na vault
```
vault secrets enable database
```

Konfiguracja połączenia do bazy z vaulta
```
vault write database/config/postgresql \
        plugin_name=postgresql-database-plugin \
        allowed_roles=readonly \
        connection_url=postgresql://postgres:password@mydb-postgresql/postgres?sslmode=disable
```

Utworzenie szablonu roli, którą będzie tworzył vault na bazie danych

```
cat << EOF > /tmp/vault-postgres.sql
CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "{{name}}";
EOF
```
```
vault write database/roles/readonly db_name=postgresql \
        creation_statements=@/tmp/vault-postgres.sql \
        default_ttl=60s max_ttl=120s
```
Utworzenie polityki zezwalającej na pobieranie danych logowania do bazy
```
cat << EOF > /tmp/postgres-policy.hcl
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
EOF
```

```
vault policy write dbapps /tmp/postgres-policy.hcl
```
```
vault write auth/kubernetes/role/myapp \
   bound_service_account_names=app \
   bound_service_account_namespaces='*' \
   policies=app,dbapps \
   ttl=1h
```
Weryfikacja

Uruchomienie testowego kontenera z postgresql

```
kubectl run -i --tty --rm debug --image=postgres:alpine --restart=Never -- sh
```

Dodanie aplikacji z konfiguracją
```
kubectl apply -f db_deploy.yaml 
kubectl exec -it nazwa_poda -- cat /vault/secrets/dbcreds
```