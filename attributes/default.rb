#<> Ensure that apt cache is up to date at compile time (build-essential)
default['apt']['compile_time_update'] = true

default['redmine']['hostname'] = 'forge.typo3.org'
default['redmine']['source']['repository'] = 'git://github.com/TYPO3-infrastructure/redmine.git'
default['redmine']['source']['reference'] = '3.3-stable-typo3'

default['redmine']['thin_servers'] = '4'

override['redmine']['deploy']['additional_symlinks'] = {
  'public/headerimages' => 'public/headerimages',
}

override['redmine']['deploy']['additional_directories'] = %w{
  shared/public/headerimages
}

# Send mails for user "redmine" to "root"
default['postfix']['aliases']['redmine'] = 'root'
