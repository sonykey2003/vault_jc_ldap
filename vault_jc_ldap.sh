#starting the vault server in dev mode
vault server -dev

#do this in a separate ssh session
export VAULT_ADDR='http://127.0.0.1:8200'
vault auth enable ldap

echo -n | openssl s_client -connect ldap.jumpcloud.com:636 -showcerts | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/jumpcloud.chain.pem

#ldaps JC
vault write auth/ldap/config \
 url="ldaps://ldap.jumpcloud.com" \
 certificate=@/tmp/jumpcloud.chain.pem \
 userattr=uid \
 userdn="ou=Users,o=<yourorgid>,dc=jumpcloud,dc=com" \
 groupdn="ou=Users,o=<yourorgid>,dc=jumpcloud,dc=com" \
 binddn="uid=vault.ldap,ou=Users,o=<yourorgid>,dc=jumpcloud,dc=com" \
 bindpass=<yourpw> \
 groupfilter="(member={{.UserDN}})" \
 groupattr="memberOf" \
 token_policies="testldappolicy"

tee systems.hcl <<EOF
path "secret/data/*" {
  capabilities = ["read", "list"]
}
EOF

tee systems_rw.hcl <<EOF
path "secret/data/*" {
	capabilities = ["create", "read", "update", "delete", "list"]
}
EOF

vault policy write systems systems.hcl
vault policy write systems_rw systems_rw.hcl
 
vault write auth/ldap/groups/systems policies=systems
vault write auth/ldap/groups/systems_rw policies=systems_rw

vault login -method ldap username=<ldapuser>
