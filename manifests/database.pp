# = Definition: percona::database
#
# A basic helper used to create a database.
#
# == Parameters:
#
# $ensure::   Defaults to present
#
# $charset::  Character set to use when creating the database.
#
# $mgmt_cnf:: Management config file to use while creating
#             the database. Defaults to undefined.
#
define percona::database (
  $ensure   = 'present',
  $charset  = 'utf8',
  $mgmt_cnf = undef
) {

  $mycnf = $mgmt_cnf ? {
    undef   => $::percona::mgmt_cnf,
    default => $mgmt_cnf,
  }

  percona_mysql_database { $name:
    ensure   => $ensure,
    charset  => $charset,
    mgmt_cnf => $mycnf,
    require  => Service[$::percona::service_name],
  }

}
