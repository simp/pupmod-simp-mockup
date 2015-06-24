# == Class dummy::config::firewall
#
# This class is meant to be called from dummy.
# It ensures that firewall rules are defined.
#
class dummy::config::firewall {

  # FIXME: ensure yoour module's firewall settings are defined here.
  iptables::add_tcp_stateful_listen { 'allow_dummy_tcp_connections':
    client_nets => $::dummy::client_nets,
    dports      => $::dummy::tcp_listen_port,
  }

}
