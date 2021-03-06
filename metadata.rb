name             "site-forgetypo3org"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures forge.typo3.org"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.0.1'

depends "t3-base",          "~> 0.2.0"

depends "t3-mysql",         "~> 5.1.0"
depends "openssl",          "~> 4.4.0"
depends "redmine",          "~> 1.0.0"
depends "ssl_certificates", "~> 1.1.3"
depends "t3-chef-vault",    "~> 1.0.1"

depends "chef_nginx",       "= 5.1.3"
