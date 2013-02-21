default['site-forgetypo3org']['ssl_certificate'] = "wildcard.typo3.org"

# credentials for mysql user for svn authorization
# this is used on the svn server and read through the site-svntypo3org cookbook
default['site-forgetypo3org']['database_svn']['username'] = "svntypo3org"
default['site-forgetypo3org']['database_svn']['password'] = nil