# @summary Ensures services are running
# @api private
class dummy::service {
  assert_private()

  service { $::dummy::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true
  }
}
