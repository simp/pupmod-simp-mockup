Summary: A simple dummy designed to test Travis.
Name: pupmod-dummy
Version: 0.1.3
Release: 0
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: pupmod-iptables >= 2.0.0-0
Requires: puppet >= 3.3.0
Buildarch: noarch

Prefix: /etc/puppet/environments/simp/modules

%description
A simple dummy designed to test Travis.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/dummy

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/dummy
done

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/dummy

%files
%defattr(0640,root,puppet,0750)
%{prefix}/dummy

%post
#!/bin/sh

%postun
# Post uninstall stuff

%changelog
* Wed Jul 08 2015 Chris Tessmer - 0.1.3-0
- Initial package.
