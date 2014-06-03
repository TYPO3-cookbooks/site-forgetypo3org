# generic defaults
default['site-forgetypo3org']['ssl_certificate'] = 'wildcard.typo3.org'

default['site-forgetypo3org']['sso_enabled'] = true

default['site-forgetypo3org']['amqp']['server'] = nil
default['site-forgetypo3org']['amqp']['user'] = nil
default['site-forgetypo3org']['amqp']['vhost'] = nil

default['redmine']['hostname'] = 'forge.typo3.org'
default['redmine']['branch'] = '1.4'
default['redmine']['source']['repository'] = 'git://github.com/TYPO3-infrastructure/redmine.git'
default['redmine']['source']['reference'] = '1.4-stable-typo3'

# override defaults for production
if node.chef_environment == 'production'
  default['site-forgetypo3org']['amqp'] = {
    'server' => 'mq.typo3.org',
    'user' => 'forgetypo3org',
    'vhost' => 'infrastructure'
  }
# override defaults for pre-production
elsif node.chef_environment == 'pre-production'
  default['site-forgetypo3org']['amqp'] = {
    'server' => 'mq.typo3.org',
    'user' => 'devforgetypo3org',
    'vhost' => 'infrastructure_dev'
  }
  default['redmine']['hostname'] = 'dev.forge.typo3.org'
end

override['redmine']['deploy']['additional_symlinks'] = {
  'public/headerimages' => 'public/headerimages',
  'config/amqp.yml' => 'config/amqp.yml',
}
override['redmine']['deploy']['additional_directories'] = %w{
  shared/public/headerimages
}

