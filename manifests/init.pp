# Class: bamboo
#
# This module manages Atlassian Bamboo
#
# Parameters:
#
# Actions:
#
# Requires:
#
#	Define['wget']
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class bamboo (
  $version = '4.1.2',
  $installdir = '/usr/local'){

  $srcdir = '/usr/local/src'

  wget::fetch { 'bamboo':
    source      => "http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${version}.tar.gz",
    destination => "${srcdir}/atlassian-bamboo-${version}.tar.gz",
  } ->
  exec { 'bamboo':
    command => "tar zxvf ${srcdir}/atlassian-bamboo-${version}.tar.gz && mv Bamboo bamboo-${version}",
    creates => "${installdir}/bamboo-${version}",
    cwd     => $installdir,
  } ->
  file { '/etc/init.d/bamboo':
    ensure => link,
    target => "${installdir}/bamboo-${version}/bamboo.sh",
  } ->
  service { 'bamboo':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

}
