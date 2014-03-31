#
# Apache 2 Module
# ---------------

require prereq


# Apache 2

class apache2 {

  class { "apache":
    default_vhost => false,
    mpm_module    => "prefork"
  }

  apache::mod { "access_compat": }
  apache::mod { "rewrite": }

  class { "apache::mod::php": }

  apache::vhost { "pp.dev":
    port          => "80",
    docroot       => "/opt/www/src/web",
    docroot_owner => "vagrant",
    docroot_group => "vagrant",
    override      => "All",
  }
}
