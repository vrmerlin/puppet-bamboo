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

*  wget => http://forge.puppetlabs.com/maestrodev/wget

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


License
=======

```
Copyright 2012 MaestroDev

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
