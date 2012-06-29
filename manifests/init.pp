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
  $installdir = '/usr/local',
  $bambooHome){

  $srcdir = '/usr/local/src'
  $bambooDir = "${installdir}/bamboo-${version}"

  wget::fetch { 'bamboo':
    source      => "http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${version}.tar.gz",
    destination => "${srcdir}/atlassian-bamboo-${version}.tar.gz",
  } ->
  exec { 'bamboo':
    command => "tar zxvf ${srcdir}/atlassian-bamboo-${version}.tar.gz && mv Bamboo bamboo-${version}",
    creates => "${installdir}/bamboo-${version}",
    cwd     => $installdir,
  } ->
  file { "${bambooHome}":
    ensure => directory,
  } ->
  file { "${bambooDir}/webapp/WEB-INF/classes/bamboo-init.properties":
    content => "bamboo.home=${bambooHome}",
  } ->
  file { '/etc/init.d/bamboo':
    ensure => link,
    target => "${bambooDir}/bamboo.sh",
  } ->
  service { 'bamboo':
    ensure     => running,
    enable     => false, # service bamboo does not support chkconfig
    hasrestart => true,
    hasstatus  => true,
  }

}
