[![License](https://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/73/badge)](https://bestpractices.coreinfrastructure.org/projects/73)
[![Puppet Forge](https://img.shields.io/puppetforge/v/simp/dummy.svg)](https://forge.puppetlabs.com/simp/dummy)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/simp/dummy.svg)](https://forge.puppetlabs.com/simp/dummy)
[![Build Status](https://travis-ci.com/simp/pupmod-simp-dummy.svg)](https://travis-ci.org/simp/pupmod-simp-dummy)

#### Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
  * [This is a (dummy) SIMP module](#this-is-a-dummy-simp-module)
* [Setup](#setup)
  * [What dummy affects](#what-dummy-affects)
  * [Beginning with dummy](#beginning-with-dummy)
* [Usage](#usage)
* [Reference](#reference)
* [Limitations](#limitations)
* [Development](#development)
  * [Acceptance tests](#acceptance-tests)

<!-- vim-markdown-toc -->

## Description

This a dummy module to test that SIMP org's CI, GitHub and Puppet Forge RELENG
pipelines, and puppet module skeleton.  It doesn't manage anything important,
and isn't meant to be used in production environments (although it shouldn't be
harmful, either).

### This is a (dummy) SIMP module

This module is a component of the [System Integrity Management
Platform](https://simp-project.com), a
compliance-management framework built on Puppet.

If you find any issues, they may be submitted to our [bug
tracker](https://simp-project.atlassian.net/).

## Setup

### What dummy affects

By design, the dummy module doesn't manage anything important.

### Beginning with dummy

```puppet
include dummy
```

## Usage

By design, the dummy module doesn't manage anything important.

## Reference

By design, the dummy module doesn't manage anything important.

## Limitations

By design, the dummy module doesn't manage anything important.

## Development

Please read our [Contribution Guide](http://simp-doc.readthedocs.io/en/stable/contributors_guide/index.html).

### Acceptance tests

This module includes [Beaker](https://github.com/puppetlabs/beaker) acceptance
tests using the SIMP [Beaker Helpers](https://github.com/simp/rubygem-simp-beaker-helpers).
By default the tests use [Vagrant](https://www.vagrantup.com/) with
[VirtualBox](https://www.virtualbox.org) as a back-end; Vagrant and VirtualBox
must both be installed to run these tests without modification. To execute the
tests run the following:

```shell
bundle install
bundle exec rake beaker:suites
```

Please refer to the [SIMP Beaker Helpers documentation](https://github.com/simp/rubygem-simp-beaker-helpers/blob/master/README.md)
for more information.
