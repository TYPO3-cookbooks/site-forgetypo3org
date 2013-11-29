default['site-forgetypo3org']['ssl_certificate'] = "wildcard.typo3.org"

override['redmine']['deploy']['additional_symlinks'] = {
  "public/headerimages" => "public/headerimages",
  "config/amqp.yml" => "config/amqp.yml",
}

normal['redmine']['deploy']['additional_directories'] = %w{
  shared/public/headerimages
}

default['site-forgetypo3org']['amqp']['server'] = nil
default['site-forgetypo3org']['amqp']['user'] = nil
default['site-forgetypo3org']['amqp']['vhost'] = nil
