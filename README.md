# puppet-bamboo

Simple Puppet module for Atlassian Bamboo

* Manages the download and installation of Bamboo
* Manages some pre-installation configuration settings, such as Tomcat ports,
  proxy configuration, Java options
* Manages a bamboo user, group, and home
* Manages a service for Bamboo

## Prerequisites

* nanliu/staging: [http://forge.puppetlabs.com/nanliu/staging](http://forge.puppetlabs.com/nanliu/staging)
* A Java installation (e.g. [puppetlabs/java](http://forge.puppetlabs.com/puppetlabs/java)

## Usage

__With defaults__

```puppet
class { 'bamboo': }
```

__With some customization__

```puppet
class { 'bamboo':
  version      => '5.9.4',
  installdir   => '/opt/bamboo',
  home         => '/var/local/bamboo',
  user         => 'bamboo',
  java_home    => '/over/the/rainbow/java',
  download_url => 'https://mirrors.example.com/atlassian/bamboo',
  context_path => 'bamboo',
  proxy        => {
    scheme    => 'https',
    proxyName => 'bamboo.example.com',
    proxyPort => '443',
  },
}
```

Refer to [manifests/init.pp](manifests/init.pp) for a list of parameters for
now until this README is improved.

## Authors and Contributors

* Refer to the [CONTRIBUTORS](CONTRIBUTORS) file.
* Original module by [MaestroDev](http://www.maestrodev.com) (http://www.maestrodev.com)
* Josh Beard (<josh@signalboxes.net>) [https://github.com/joshbeard](https://github.com/joshbeard)
* Carlos Sanchez (<csanchez@maestrodev.com>)
