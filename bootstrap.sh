#laying the grounds
sudo apt-get update
sudo apt-get install ldap-utils 
sudo apt-get install bash-completion -y
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

#installing vault
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - #Add the HashiCorp GPG key.
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault

#prep for webui
tee config.hcl <<EOF
ui = true
disable_mlock = true

storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
EOF
mkdir -p vault/data
echo "run 'vault server -config=config.hcl' to start the server "
echo "more info:https://learn.hashicorp.com/tutorials/vault/getting-started-ui?in=vault/getting-started "

#enable autocomplete
sudo -H -u vagrant bash -c 'vault -autocomplete-install'
sudo -H -u vagrant bash -c 'source ~/.bashrc'
