#
# MySQL 5 Module
# ==============

require basic
include mysql::server
include mysql::client


# MySQL 5

class mysql5 {
    class { "::mysql::server":
        root_password    => "Diablo2",
        restart          => true,
        override_options => {
            "mysqld" => { "max_connections" => "1024", "bind_address" => "0.0.0.0" }
        },
    }

    class { "::mysql::client": }

    mysql_user { "root@192.168.50.1":
        ensure                   => "present",
        password_hash            => "*8D07AC09DA75E8AA5288BBE75315580B18B78AC3",
        max_connections_per_hour => "0",
        max_queries_per_hour     => "0",
        max_updates_per_hour     => "0",
        max_user_connections     => "0",
    }

    mysql_grant { "root@192.168.50.1/*.*":
        ensure     => present,
        options    => ["GRANT"],
        privileges => ["ALL"],
        table      => "*.*",
        user       => "root@192.168.50.1",
    }
}
