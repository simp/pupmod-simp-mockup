# == Class dummy::install
#
# This class is called from dummy for install.
#
class dummy::install {

  package { $::dummy::package_name:
    ensure => present,
  }
}
