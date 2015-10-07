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
  $version            = '5.9.4',
  $extension          = 'tar.gz',
  $installdir         = '/usr/local/bamboo',
  $homedir            = '/var/local/bamboo',
  $context_path       = '',
  $tomcat_port        = '8085',
  $max_threads        = '150',
  $min_spare_threads  = '25',
  $connection_timeout = '20000',
  $accept_count       = '100',
  $proxy              = {},
  $manage_user        = true,
  $manage_group       = true,
  $user               = 'bamboo',
  $group              = 'bamboo',
  $uid                = undef,
  $gid                = undef,
  $password           = '*',
  $shell              = '/bin/bash',
  $java_home          = '/usr/lib/jvm/java',
  $jvm_xms            = '256m',
  $jvm_xmx            = '1024m',
  $jvm_permgen        = '256m',
  $jvm_opts           = '',
  $jvm_optional       = '',
  $download_url       = 'https://www.atlassian.com/software/bamboo/downloads/binary',
  $service_lockfile   = $bamboo::params::service_lockfile,
  $manage_service     = true,
  $service_ensure     = 'running',
  $service_enable     = true,
  $service_file       = $bamboo::params::service_file,
  $service_template   = $bamboo::params::service_template,
) inherits bamboo::params {

  $app_dir = "${installdir}/atlassian-bamboo-${version}"

  anchor { 'bamboo::start': } ->
  class { 'bamboo::install': } ->
  class { 'bamboo::configure': } ~>
  class { 'bamboo::service': } ->
  anchor { 'bamboo::end': }

}
