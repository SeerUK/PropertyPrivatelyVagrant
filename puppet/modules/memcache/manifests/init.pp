#
# Memcache Module
# ===============

require prereq


# Memcache

class memcache {
  package {['memcached']:
    ensure  => present,
    require => Exec['apt-get update']
  }

  $ip = "${ipaddress_eth1}"

  file { "/etc/memcached.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcache/conf/memcached.erb'),
  }
}
