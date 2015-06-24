# == Class dummy::service
#
# This class is meant to be called from dummy.
# It ensure the service is running.
#
class dummy::service {

  service { $::dummy::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
