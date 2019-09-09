# Full description of SIMP module 'dummy' here.
#
# === Welcome to SIMP!
#
# This module is a component of the System Integrity Management Platform, a
# managed security compliance framework built on Puppet.
#
# ---
# *FIXME:* verify that the following paragraph fits this module's characteristics!
# ---
#
# This module is optimally designed for use within a larger SIMP ecosystem, but
# it can be used independently:
#
# * When included within the SIMP ecosystem, security compliance settings will
#   be managed from the Puppet server.
#
# * If used independently, all SIMP-managed security subsystems are disabled by
#   default, and must be explicitly opted into by administrators.  Please
#   review the +trusted_nets+ and +$enable_*+ parameters for details.
#
# @param service_name
#   The name of the dummy service
#
# @param package_name
#   The name of the dummy package
#
# @param trusted_nets
#   A whitelist of subnets (in CIDR notation) permitted access
#
# @param enable_auditing
#   If true, manage auditing for dummy
#
# @param enable_firewall
#   If true, manage firewall rules to acommodate dummy
#
# @param enable_logging
#   If true, manage logging configuration for dummy
#
# @param enable_pki
#   If true, manage PKI/PKE configuration for dummy
#
# @param enable_selinux
#   If true, manage selinux to permit dummy
#
# @param enable_tcpwrappers
#   If true, manage TCP wrappers configuration for dummy
#
# @author SIMP Team
#
class dummy (
  String                        $service_name       = 'dummy',
  String                        $package_name       = 'dummy',
  Simplib::Port                 $tcp_listen_port    = 9999,
  Simplib::Netlist              $trusted_nets       = simplib::lookup('simp_options::trusted_nets', {'default_value' => ['127.0.0.1/32'] }),
  Variant[Boolean,Enum['simp']] $enable_pki         = simplib::lookup('simp_options::pki', { 'default_value'         => false }),
  Boolean                       $enable_auditing    = simplib::lookup('simp_options::auditd', { 'default_value'      => false }),
  Variant[Boolean,Enum['simp']] $enable_firewall    = simplib::lookup('simp_options::firewall', { 'default_value'    => false }),
  Boolean                       $enable_logging     = simplib::lookup('simp_options::syslog', { 'default_value'      => false }),
  Boolean                       $enable_selinux     = simplib::lookup('simp_options::selinux', { 'default_value'     => false }),
  Boolean                       $enable_tcpwrappers = simplib::lookup('simp_options::tcpwrappers', { 'default_value' => false })
) {

  simplib::assert_metadata($module_name)

  include '::dummy::install'
  include '::dummy::config'
  include '::dummy::service'

  Class[ '::dummy::install' ]
  -> Class[ '::dummy::config' ]
  ~> Class[ '::dummy::service' ]

  if $enable_pki {
    include '::dummy::config::pki'
    Class[ '::dummy::config::pki' ]
    -> Class[ '::dummy::service' ]
  }

  if $enable_auditing {
    include '::dummy::config::auditing'
    Class[ '::dummy::config::auditing' ]
    -> Class[ '::dummy::service' ]
  }

  if $enable_firewall {
    include '::dummy::config::firewall'
    Class[ '::dummy::config::firewall' ]
    -> Class[ '::dummy::service' ]
  }

  if $enable_logging {
    include '::dummy::config::logging'
    Class[ '::dummy::config::logging' ]
    -> Class[ '::dummy::service' ]
  }

  if $enable_selinux {
    include '::dummy::config::selinux'
    Class[ '::dummy::config::selinux' ]
    -> Class[ '::dummy::service' ]
  }

  if $enable_tcpwrappers {
    include '::dummy::config::tcpwrappers'
    Class[ '::dummy::config::tcpwrappers' ]
    -> Class[ '::dummy::service' ]
  }
}











