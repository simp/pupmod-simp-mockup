# @summary Installs packages
# @api private
class dummy::install {
  assert_private()

  package { $::dummy::package_name:
    ensure => $::dummy::package_ensure
  }
}
