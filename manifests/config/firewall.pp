# == Class dummy::config::firewall
#
# This class is meant to be called from dummy.
# It ensures that firewall rules are defined.
#
class dummy::config::firewall {
  assert_private()

  # FIXME: ensure your module's firewall settings are defined here.
  iptables::listen::tcp_stateful { 'allow_dummy_tcp_connections':
    trusted_nets => $::dummy::trusted_nets,
    dports       => $::dummy::tcp_listen_port
  }
}
