name             "site-forgetypo3org"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures forge.typo3.org"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.0.22"

depends "redmine",          "~> 0.2.0"
depends "nginx",            "= 1.6.0"
depends "ssl_certificates", "= 1.1.3"
depends "mysql",            "= 1.3.0"
depends "php",              "= 1.1.2"
depends "t3-chef-vault",    "= 1.0.1"
