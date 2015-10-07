puppet-bamboo
=============

Simple Puppet module for Atlassian Bamboo

* Downloads Bamboo tarball from Atlassian
* Installs it into /usr/local by default
* Configures Bamboo home
* Starts the service running as 'bamboo' user by default
* Allows simple upgrades by just changing the version

Module requirements
===================

*  staging => http://forge.puppetlabs.com/nanliu/staging

Usage
=====

```
class { 'bamboo': }
```

or

```
class { 'bamboo':
  version    => '4.4.0',
  installdir => '/usr/local',
  home       => '/var/local/bamboo',
  user       => 'bamboo',
}
```

Changelog
=========

2.0.0
-----
Works with Bamboo 4.4+

1.0.0
-----
Works with Bamboo up to 4.4

Author
======

[MaestroDev](http://www.maestrodev.com) http://www.maestrodev.com
Carlos Sanchez <csanchez@maestrodev.com>
2012-07-03
