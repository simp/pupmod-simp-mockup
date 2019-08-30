# == Class dummy::install
#
# This class is called from dummy for install.
#
class dummy::install {
  assert_private()

  package { $::dummy::package_name:
    ensure => present
  }
}
