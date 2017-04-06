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
