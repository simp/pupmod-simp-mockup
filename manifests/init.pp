# == Class: dummy
#
# Full description of SIMP module 'dummy' here.
#
# === Welcome to SIMP!
# This module is a component of the System Integrity Management Platform, a
# a managed security compliance framework built on Puppet.
#
# _*FIXME: verify that the following paragraph fits this module's characteristics!*_
#
# This module is optimally designed for use within a larger SIMP ecosystem, but
# it can be used independently:
#
# * When included within the SIMP ecosystem,
#   security compliance settings will be managed from the Puppet server.
#
# * If used independently, all SIMP-managed security subsystems are disabled by
#   default, and must be explicitly opted into by administrators.  Please review
#   the `client_nets` and `$enable_*` parameters for details.
#
#
# == Parameters
#
# [*service_name*]
# Type: String
# Default:  $::dummy::params::service_name
#   The name of the dummy service.
#
# [*package_name*]
# Type: String
# Default:  $::dummy::params::package_name
#   The name of the dummy package.
#
# [*client_nets*]
# Type: Array of Strings
# Default: ['127.0.0.1/32']
#   A whitelist of subnets (in CIDR notation) permitted access.
#
# [*enable_auditing*]
# Type: Boolean
# Default: false
#   If true, manage auditing for dummy.
#
# [*enable_firewall*]
# Type: Boolean
# Default: false
#   If true, manage firewall rules to acommodate dummy.
#
# [*enable_logging*]
# Type: Boolean
# Default: false
#   If true, manage logging configuration for dummy.
#
# [*enable_pki*]
# Type: Boolean
# Default: false
#   If true, manage PKI/PKE configuration for dummy.
#
# [*enable_selinux*]
# Type: Boolean
# Default: false
#   If true, manage selinux to permit dummy.
#
# [*enable_tcpwrappers*]
# Type: Boolean
# Default: false
#   If true, manage TCP wrappers configuration for dummy.
#
# == Authors
#
# * Chris Tessmer
#
class dummy (
  $service_name    = $::dummy::params::service_name,
  $package_name    = $::dummy::params::package_name,
  $tcp_listen_port = '99999',

  $client_nets     = defined('$::client_nets') ? { true => $::client_nets, default => hiera('client_nets', ['127.0.0.1/32']) },

  $enable_auditing = defined('$::enable_auditing') ? { true => $::enable_auditing, default => hiera('enable_auditing',false) },
  $enable_firewall = defined('$::enable_firewall') ? { true => $::enable_firewall, default => hiera('enable_firewall',false) },
  $enable_logging  = defined('$::enable_logging')  ? { true => $::enable_logging,  default => hiera('enable_logging',false) },
  $enable_pki  = defined('$::enable_pki')  ? { true => $::enable_pki,  default => hiera('enable_pki',false) },
  $enable_selinux  = defined('$::enable_selinux')  ? { true => $::enable_selinux,  default => hiera('enable_selinux',false) },
  $enable_tcpwrappers  = defined('$::enable_tcpwrappers')  ? { true => $::enable_tcpwrappers,  default => hiera('enable_tcpwrappers',false) }

) inherits ::dummy::params {

  validate_string( $service_name )
  validate_string( $package_name )
  validate_string( $tcp_listen_port )
  validate_array( $client_nets )
  validate_bool( $enable_auditing )
  validate_bool( $enable_firewall )
  validate_bool( $enable_logging )
  validate_bool( $enable_pki )
  validate_bool( $enable_selinux )
  validate_bool( $enable_tcpwrappers )

  include '::dummy::install'
  include '::dummy::config'
  include '::dummy::service'
  Class[ '::dummy::install' ] ->
  Class[ '::dummy::config'  ] ~>
  Class[ '::dummy::service' ] ->
  Class[ '::dummy' ]

  if $enable_auditing {
   include '::dummy::config::auditing'
   Class[ '::dummy::config::auditing' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_firewall {
   include '::dummy::config::firewall'
   Class[ '::dummy::config::firewall' ] ->
   Class[ '::dummy::service'  ]
  }

  if $enable_logging {
   include '::dummy::config::logging'
   Class[ '::dummy::config::logging' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_pki {
   include '::dummy::config::pki'
   Class[ '::dummy::config::pki' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_selinux {
   include '::dummy::config::selinux'
   Class[ '::dummy::config::selinux' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_tcpwrappers {
   include '::dummy::config::tcpwrappers'
   Class[ '::dummy::config::tcpwrappers' ] ->
   Class[ '::dummy::service' ]
  }
}
