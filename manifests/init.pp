# @summary TODO: Summary describing the SIMP class 'dummy'
#
# @example Basic usage
#   include  'dummy'
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
# @param auditing
#   If true, manage auditing for dummy
#
# @param firewall
#   If true, manage firewall rules to acommodate dummy
#
# @param logging
#   If true, manage logging configuration for dummy
#
# @param pki
#   If true, manage PKI/PKE configuration for dummy
#
# @param selinux
#   If true, manage selinux to permit dummy
#
# @param tcpwrappers
#   If true, manage TCP wrappers configuration for dummy
#
# @author SIMP
#
class dummy (
  String                             $service_name       = 'dummy',
  String                             $package_name       = 'dummy',
  String[1]                          $package_ensure     = simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' }),
  Simplib::Port                      $tcp_listen_port    = 9999,
  Simplib::Netlist                   $trusted_nets       = simplib::lookup('simp_options::trusted_nets', {'default_value' => ['127.0.0.1/32'] }),
  Variant[Boolean,Enum['simp']]      $pki         = simplib::lookup('simp_options::pki', { 'default_value'         => false }),
  Boolean                            $auditing    = simplib::lookup('simp_options::auditd', { 'default_value'      => false }),
  Variant[Boolean,Enum['firewalld']] $firewall    = simplib::lookup('simp_options::firewall', { 'default_value'    => false }),
  Boolean                            $logging     = simplib::lookup('simp_options::syslog', { 'default_value'      => false }),
  Boolean                            $selinux     = simplib::lookup('simp_options::selinux', { 'default_value'     => false }),
  Boolean                            $tcpwrappers = simplib::lookup('simp_options::tcpwrappers', { 'default_value' => false }),
  Boolean                            $foo         = true,
) {

  simplib::assert_metadata($module_name)

  include 'dummy::install'
  include 'dummy::config'
  include 'dummy::service'

  Class[ 'dummy::install' ]
  -> Class[ 'dummy::config' ]
  ~> Class[ 'dummy::service' ]

  if $pki {
    include 'dummy::config::pki'
    Class[ 'dummy::config::pki' ]
    -> Class[ 'dummy::service' ]
  }

  if $auditing {
    include 'dummy::config::auditing'
    Class[ 'dummy::config::auditing' ]
    -> Class[ 'dummy::service' ]
  }

  if $firewall {
    include 'dummy::config::firewall'
    Class[ 'dummy::config::firewall' ]
    -> Class[ 'dummy::service' ]
  }

  if $logging {
    include 'dummy::config::logging'
    Class[ 'dummy::config::logging' ]
    -> Class[ 'dummy::service' ]
  }

  if $selinux {
    include 'dummy::config::selinux'
    Class[ 'dummy::config::selinux' ]
    -> Class[ 'dummy::service' ]
  }

  if $tcpwrappers {
    include 'dummy::config::tcpwrappers'
    Class[ 'dummy::config::tcpwrappers' ]
    -> Class[ 'dummy::service' ]
  }
}
