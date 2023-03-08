# Description
PoC with Vault Agent Service

# Start Vault as Docker service in development mode

In this mode Vault only save configurations and secrets in memor. Only use this mode for some checks:

```
docker run --name vault -d --cap-add=IPC_LOCK -e VAULT_DEV_ROOT_TOKEN_ID=root -e 'VAULT_LOCAL_CONFIG={"storage": {"file": {"path": "/vault/file"}}, "listener": [{"tcp": { "address": "0.0.0.0:8200", "tls_disable": true}}], "default_lease_ttl": "168h", "max_lease_ttl": "720h", "ui": true}' -p 8200:8200 vault server
```

Export the uri where vault is listening

```
export VAULT_ADDR='http://0.0.0.0:8200'
```

# Start Vault as Docker service in production mode

```
docker run --name vault -d --cap-add=IPC_LOCK -e 'VAULT_LOCAL_CONFIG={"storage": {"file": {"path": "/vault/file"}}, "listener": [{"tcp": { "address": "0.0.0.0:8200", "tls_disable": true}}], "default_lease_ttl": "168h", "max_lease_ttl": "720h", "ui": true}' -p 8200:8200 vault server
```

**STEP01**: Configure root keys in emeerngy case. Set 1 and 1 in both attributes

![vault-production-config_01](captures/vault_production_config_ste01.png)

**STEP02**: The system create for us two keys. This keys will be used to login in UI later. We can download

- intial root token: hvs.7oo9iGaYJyjBk7EADaBE0Xha
- Key 1: 58f289a6fef1d68db93fd143d082f1f9f821b8ff0c2d2752325c55ac538f3b44

![vault-production-config_02](captures/vault_production_config_ste02.png)

**STEP03: Now continue with the Unseal configuration

We must introduce the Key 1 created previously to finish the configuration

![vault-production-config_03](captures/vault_production_config_ste03.png)

**STEP04**: We can login using the root key created for us

![vault-production-config_04](captures/vault_production_config_ste04.png)

![vault-production-config_05](captures/vault_production_config_ste05.png)

# Check Vault service

Check vault status

```
vault status

Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.13.0
Build Date      2023-03-01T14:58:13Z
Storage Type    inmem
Cluster Name    vault-cluster-35964baf
Cluster ID      da5425e5-f11a-e97e-2ebb-2de0169ba90f
HA Enabled      false
```

Login in vault status using the previous VAULT_DEV_ROOT_TOKEN_ID value

```
vault login root
```

# Access to Vault UI

```
http://localhost:8200/
```

Access using toke authentication method and the token VAULT_DEV_ROOT_TOKEN_ID

![vault-ui](captures/vault_ui.png)

## create new access methods to vault

By default vault only activate the token access. We are activate the username/password access and create a new account for this new type

From Access Menu option click the button Enabled new method

![vault-methods](captures/vault_methods.png)

Select Username& Passrod option and click Next

![vault-username_password_method](captures/vault_username_password_method.png)

The new access method is showed in this list

## Manage access methods and accounts

select the username/password access method and create a new account cliking in Create user

![vault-username_password_method](captures/userna_password_credentials.png)

the new account is showed in the list of this method

![vault-username_password_method](captures/username_password_account.png)

Login with the new accound

```
vault login -method=userpass username=masalinas password=password
```

## Manage secrets engines