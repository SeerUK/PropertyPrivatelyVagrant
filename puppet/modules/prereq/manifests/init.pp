#
# Shared Prerequisites
# ====================

class prereq {
  exec { 'apt-get update':
    alias   => 'aptupdate',
    command => '/usr/bin/apt-get update'
  }

  package {['vim', 'htop', 'iotop', 'screen']:
    ensure  => present,
    require => Exec['apt-get update']
  }

  class { apt: }

  apt::ppa { 'ppa:chris-lea/node.js': }

  class { 'nodejs':
    require => Apt::Ppa['ppa:chris-lea/node.js']
  }

  package {['grunt-cli', 'bower']:
    ensure   => present,
    provider => 'npm',
    require  => Package['nodejs']
  }
}

