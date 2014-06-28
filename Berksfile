#chef_api :config
#chef_api "https://chef.typo3.org/clients/", node_name: "pniederlag", client_key: "/srv/fileserver/projects/t3-team-server/certificates/client.pem"


cookbook "mysql", github: "opscode-cookbooks/mysql", ref: "1.3.0"
cookbook "ssl_certificates", github: "TYPO3-cookbooks/ssl_certificates"
cookbook "t3-chef-vault", github: "TYPO3-cookbooks/t3-chef-vault"
cookbook "redmine", github: "TYPO3-cookbooks/redmine"
cookbook "php", github: "TYPO3-cookbooks/php", branch: "master"
cookbook "chef-solo-search", github: "edelight/chef-solo-search"
cookbook "git"

site :opscode
metadata

