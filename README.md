# Deploy Vault and setup LDAP auth with JumpCloud on Vagrant
> Vault Server Dev mode will be used through out the guide, DO NOT deploy it in prod.

A quick guide for playing around with Vault with a JumpCloud as the auth backborne. 

## Getting Started

**You will need:**
* A JumpCloud Tenant - You can [register for free.](https://console.jumpcloud.com/signup)
* [Install Vagrant](https://www.vagrantup.com/docs/installation)  on your dev box. 


## Step-By-Step

On JumpCloud:
1. Create an [LDAP binding account](https://support.jumpcloud.com/support/s/article/using-jumpclouds-ldap-as-a-service1#createuser) on JumpCloud.
2. Create desired [groups](https://support.jumpcloud.com/support/s/article/creating-ldap-groups-2019-08-21-10-36-47) and add users. 


On Vagrant:
1. Recommended to run line-by-lines in vault_jc_ldap.sh
2. You will get this message once logged in successfully via LDAP:
```sh
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  <>
token_accessor         <>
token_duration         768h
token_renewable        true
token_policies         ["default" "systems_rw"]
identity_policies      []
policies               ["default" "systems_rw"]
token_meta_username    vault.sys_rw
```

3. Now you can create your [first secret](https://learn.hashicorp.com/tutorials/vault/getting-started-first-secret) and switch between different LDAP user - i.e. the read-only user to test out the policy. 

Enjoy!