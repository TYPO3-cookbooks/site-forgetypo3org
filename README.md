Description
===========

[![Build Status](https://travis-ci.org/TYPO3-cookbooks/site-forgetypo3org.png)](https://travis-ci.org/TYPO3-cookbooks/site-forgetypo3org)

This cookbook extends the [Redmine](http://github.com/typo3-cookbooks/redmine) for our needs on [forge.typo3.org](http://forge.typo3.org)

## Testing

### Specify a user's password

Set `node['site-forgetypo3org']['sso_enabled'] = false`.

```bash
redmine@/srv/redmine/current$ RAILS_ENV=production bundle exec bin/rails runner 'u = User.find_by_login "my_username"; u.password, u.password_confirmation = "my_password"; u.save!'
```

As long as no exception occurs, it should have worked (there's some help text shown..).

## Git Repositories

The Git repositories stored in `/var/git/repositories` are updated by the Gerrit server through its replication.

To allow these SSH logins, the public key from the Gerrit server (`/var/gerrit/.ssh/id_rsa-replication-forge.typo3.org.pub`) has to be manually copied to the forge server's `/var/git/.ssh/authorized_keys`. 
