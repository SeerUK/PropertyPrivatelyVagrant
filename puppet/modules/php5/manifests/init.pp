#
# PHP 5 Module
# ============

require prereq


# PHP 5

class php5 {
    class { 'php':
        require => Package['apache2'],
        notify  => Service['apache2'],
    }

    php::module {[
        'cli',
        'gd',
        'intl',
        'memcache',
        'memcached',
        'mysql',
        'xdebug'
        ]:
        require => Package['php'],
        notify  => Service['apache2'],
    }

    php::module { 'apc':
        require => Package['php'],
        module_prefix => 'php-',
        notify        => Service ['apache2'],
    }

    package { 'libapache2-mod-php5':
        require => Package['php'],
        ensure  => present,
        notify  => Service ['apache2'],
    }

    augeas { 'set-php-ini-values':
        context => '/files/etc/php5/apache2/php.ini',
        changes => [
            "set PHP/error_reporting 'E_ALL | E_STRICT'",
            'set PHP/display_errors On',
            'set PHP/display_startup_errors On',
            'set PHP/html_errors On',
            'set PHP/short_open_tag Off',
            'set Date/date.timezone Europe/London',
        ],
        require => Package['php'],
        notify  => Service['apache2'],
    }
}
