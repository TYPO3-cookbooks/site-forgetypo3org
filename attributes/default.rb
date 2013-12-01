default['site-forgetypo3org']['ssl_certificate'] = 'wildcard.typo3.org'


default['site-forgetypo3org']['amqp']['server'] = nil
default['site-forgetypo3org']['amqp']['user'] = nil
default['site-forgetypo3org']['amqp']['vhost'] = nil

default['site-forgetypo3org']['amqp'] = {
  'server' => 'mq.typo3.org',
  'user' => 'forgetypo3org',
  'vhost' => 'infrastructure'
}

override['redmine']['deploy']['additional_symlinks'] = {
  'public/headerimages' => 'public/headerimages',
  'config/amqp.yml' => 'config/amqp.yml',
}
override['redmine']['deploy']['additional_directories'] = %w{
  shared/public/headerimages
}
override['redmine']['hostname'] = 'forge.typo3.org'
override['redmine']['branch'] = '1.4'
override['redmine']['source']['repository'] = 'git://github.com/TYPO3-infrastructure/redmine.git'
override['redmine']['source']['reference'] = '1.4-stable-typo3'
