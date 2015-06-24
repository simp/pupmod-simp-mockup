# == Class dummy::params
#
# This class is meant to be called from dummy.
# It sets variables according to platform.
#
class dummy::params {
  case $::osfamily {
    'RedHat': {
      $package_name = 'dummy'
      $service_name = 'dummy'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
