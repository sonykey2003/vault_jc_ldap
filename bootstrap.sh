#laying the grounds
sudo apt-get update
sudo apt-get install ldap-utils 
sudo apt-get install bash-completion -y
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

#installing vault
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - #Add the HashiCorp GPG key.
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault


#enable autocomplete
sudo -H -u vagrant bash -c 'vault -autocomplete-install'
sudo -H -u vagrant bash -c 'source ~/.bashrc'
