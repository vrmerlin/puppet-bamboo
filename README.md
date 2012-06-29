puppet-bamboo
=============

Simple Puppet module for Atlassian Bamboo

Usage
=====

```
class { 'bamboo': }
```

or

```
class { 'bamboo':
  version    => '4.1.2',
  installdir => '/usr/local',
  home       => '/var/local/bamboo',
  user       => 'bamboo',
}
```
