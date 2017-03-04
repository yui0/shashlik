%define DISTDIR	/opt

Summary: shashlik
Name: shashlik
Version: 0.9.3
Release: b3
License: MPL/LGPL
Group: Applications/System
Source: %{name}-%{version}.tar.bz2
URL: http://www.shashlik.io/
BuildRoot: %{_tmppath}/%{name}-%{version}-root
#Requires:
NoSource: 0

%description
Android Applications on Real Linux.


%prep
rm -rf $RPM_BUILD_ROOT
%setup -c -q

%install
rm -rf $RPM_BUILD_ROOT

mkdir -p $RPM_BUILD_ROOT{%{DISTDIR}/shashlik,%{_bindir}}
cp -a shashlik/* $RPM_BUILD_ROOT%{DISTDIR}/shashlik
rm $RPM_BUILD_ROOT%{DISTDIR}/shashlik/*.spec

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-, root, root, 0755)
/opt/shashlik/
#/usr/share/applications/


%changelog
* Mon Feb 27 2017 Yuichiro Nakada <berry@berry-lab.net>
- Create for Berry Linux
