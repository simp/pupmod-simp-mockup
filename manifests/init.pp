# == Class: dummy
#
# Full description of SIMP module 'dummy' here.
#
# === Welcome to SIMP!
# This module is a component of the System Integrity Management
# Platform.  It can be used independently from other SIMP
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
# [*enable_firewall*]
# Type: Boolean
# Default: false
#   If true, manage firewall rules to acommodate dummy.
#
# [*enable_selinux*]
# Type: Boolean
# Default: false
#   If true, manage selinux to permit dummy.
#
# [*enable_auditing*]
# Type: Boolean
# Default: false
#   If true, manage auditing for dummy.
#
# [*enable_logging*]
# Type: Boolean
# Default: false
#   If true, manage logging configuration for dummy.
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

  $enable_firewall = defined('$::enable_firewall') ? { true => $::enable_firewall, default => hiera('enable_firewall',false) },
  $enable_selinux  = defined('$::enable_selinux')  ? { true => $::enable_selinux,  default => hiera('enable_selinux',false) },
  $enable_auditing = defined('$::enable_auditing') ? { true => $::enable_auditing, default => hiera('enable_auditing',false) },
  $enable_logging  = defined('$::enable_logging')  ? { true => $::enable_logging,  default => hiera('enable_logging',false) }

) inherits ::dummy::params {

  validate_string( $service_name )
  validate_string( $package_name )
  validate_string( $tcp_listen_port )
  validate_array( $client_nets )
  validate_bool( $enable_firewall )
  validate_bool( $enable_selinux )
  validate_bool( $enable_auditing )
  validate_bool( $enable_logging )

  include '::dummy::install'
  include '::dummy::config'
  include '::dummy::service'
  Class[ '::dummy::install' ] ->
  Class[ '::dummy::config'  ] ~>
  Class[ '::dummy::service' ] ->
  Class[ '::dummy' ]

  if $enable_firewall {
   include '::dummy::firewall'
   Class[ '::dummy::firewall' ] ->
   Class[ '::dummy::service'  ]
  }

  if $enable_selinux {
   include '::dummy::selinux'
   Class[ '::dummy::selinux' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_auditing {
   include '::dummy::auditing'
   Class[ '::dummy::auditing' ] ->
   Class[ '::dummy::service' ]
  }

  if $enable_logging {
   include '::dummy::logging'
   Class[ '::dummy::logging' ] ->
   Class[ '::dummy::service' ]
  }
}
