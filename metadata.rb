name             "site-forgetypo3org"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures forge.typo3.org"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.0.19"

depends "redmine", "~> 0.2.0"
depends "nginx"
depends "ssl_certificates"
depends "mysql"
depends "php"
depends "t3-chef-vault"
