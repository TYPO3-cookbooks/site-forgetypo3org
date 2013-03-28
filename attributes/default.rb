default['site-forgetypo3org']['ssl_certificate'] = "wildcard.typo3.org"

# credentials for mysql user for svn authorization
# this is used on the svn server and read through the site-svntypo3org cookbook
default['site-forgetypo3org']['database_svn']['username'] = "svntypo3org"
default['site-forgetypo3org']['database_svn']['password'] = nil

normal['redmine']['deploy']['additional_symlinks'] = {
  "public/headerimages" => "public/headerimages",
  "config/amqp.yml" => "config/amqp.yml",
}

normal['redmine']['deploy']['additional_directories'] = %w{
  shared/public/headerimages
}

default['site-forgetypo3org']['amqp']['server'] = nil
default['site-forgetypo3org']['amqp']['user'] = nil
default['site-forgetypo3org']['amqp']['vhost'] = nil
