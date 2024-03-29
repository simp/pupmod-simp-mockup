# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`dummy`](#dummy): TODO: Summary describing the SIMP class 'dummy'

#### Private Classes

* `dummy::config`: Configures services
* `dummy::config::auditing`: Ensures that auditing rules are defined
* `dummy::config::firewall`: Ensures that firewall rules are defined
* `dummy::config::logging`: Ensures that logging rules are defined
* `dummy::config::pki`: Ensures that pki rules are defined
* `dummy::config::selinux`: Ensures that selinux rules are defined
* `dummy::config::tcpwrappers`: ensures that tcpwrappers rules are defined
* `dummy::install`: Installs packages
* `dummy::service`: Ensures services are running

## Classes

### <a name="dummy"></a>`dummy`

TODO: Summary describing the SIMP class 'dummy'

#### Examples

##### Basic usage

```puppet
include  'dummy'
```

#### Parameters

The following parameters are available in the `dummy` class:

* [`service_name`](#-dummy--service_name)
* [`package_name`](#-dummy--package_name)
* [`trusted_nets`](#-dummy--trusted_nets)
* [`auditing`](#-dummy--auditing)
* [`firewall`](#-dummy--firewall)
* [`logging`](#-dummy--logging)
* [`pki`](#-dummy--pki)
* [`selinux`](#-dummy--selinux)
* [`tcpwrappers`](#-dummy--tcpwrappers)
* [`foo`](#-dummy--foo)
* [`package_ensure`](#-dummy--package_ensure)
* [`tcp_listen_port`](#-dummy--tcp_listen_port)
* [`bar`](#-dummy--bar)

##### <a name="-dummy--service_name"></a>`service_name`

Data type: `String`

The name of the dummy service

Default value: `'dummy'`

##### <a name="-dummy--package_name"></a>`package_name`

Data type: `String`

The name of the dummy package

Default value: `'dummy'`

##### <a name="-dummy--trusted_nets"></a>`trusted_nets`

Data type: `Simplib::Netlist`

A whitelist of subnets (in CIDR notation) permitted access

Default value: `simplib::lookup('simp_options::trusted_nets', {'default_value' => ['127.0.0.1/32'] })`

##### <a name="-dummy--auditing"></a>`auditing`

Data type: `Boolean`

If true, manage auditing for dummy

Default value: `simplib::lookup('simp_options::auditd', { 'default_value'      => false })`

##### <a name="-dummy--firewall"></a>`firewall`

Data type: `Variant[Boolean,Enum['firewalld']]`

If true, manage firewall rules to acommodate dummy

Default value: `simplib::lookup('simp_options::firewall', { 'default_value'    => false })`

##### <a name="-dummy--logging"></a>`logging`

Data type: `Boolean`

If true, manage logging configuration for dummy

Default value: `simplib::lookup('simp_options::syslog', { 'default_value'      => false })`

##### <a name="-dummy--pki"></a>`pki`

Data type: `Variant[Boolean,Enum['simp']]`

If true, manage PKI/PKE configuration for dummy

Default value: `simplib::lookup('simp_options::pki', { 'default_value'         => false })`

##### <a name="-dummy--selinux"></a>`selinux`

Data type: `Boolean`

If true, manage selinux to permit dummy

Default value: `simplib::lookup('simp_options::selinux', { 'default_value'     => false })`

##### <a name="-dummy--tcpwrappers"></a>`tcpwrappers`

Data type: `Boolean`

If true, manage TCP wrappers configuration for dummy

Default value: `simplib::lookup('simp_options::tcpwrappers', { 'default_value' => false })`

##### <a name="-dummy--foo"></a>`foo`

Data type: `Boolean`

A new API thingamie

Default value: `true`

##### <a name="-dummy--package_ensure"></a>`package_ensure`

Data type: `String[1]`



Default value: `simplib::lookup('simp_options::package_ensure', { 'default_value' => 'installed' })`

##### <a name="-dummy--tcp_listen_port"></a>`tcp_listen_port`

Data type: `Simplib::Port`



Default value: `9999`

##### <a name="-dummy--bar"></a>`bar`

Data type: `Boolean`



Default value: `true`

