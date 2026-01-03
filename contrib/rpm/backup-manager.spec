Name:           backup-manager
Version:        0.7.18
Release:        1%{?dist}
Summary:        Simple backup tool for GNU/Linux

License:        GPLv2+
URL:            https://github.com/sukria/Backup-Manager/
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch

%global bm_libdir %{_prefix}/lib/backup-manager
%global bm_contribdir %{bm_libdir}/contrib

BuildRequires:  make
BuildRequires:  gettext
BuildRequires:  perl

Requires:       bash
Requires:       perl
Requires:       tar
Requires:       gzip
Requires:       coreutils
Requires:       sed
Requires:       util-linux

Recommends:     rsync
Recommends:     gnupg2
Recommends:     bzip2
Recommends:     xz
Recommends:     zstd
Recommends:     zip
Recommends:     openssh-clients
Recommends:     bc

%description
Backup Manager is a command line backup tool for GNU/Linux, designed to help
you make daily archives of your file system. It supports multiple archive
formats, encryption, remote uploads, and retention policies.

%prep
%autosetup -n %{name}-%{version}

%build
make build

%install
make install PREFIX=%{_prefix} DESTDIR=%{buildroot} PERL5DIR=%{perl_vendorlib}
install -d %{buildroot}%{_sysconfdir}
install -m 0644 backup-manager.conf.tpl %{buildroot}%{_sysconfdir}/backup-manager.conf
install -d %{buildroot}%{_sysconfdir}/cron.daily
install -m 0755 contrib/cron/backup-manager %{buildroot}%{_sysconfdir}/cron.daily/backup-manager

%files
%license COPYING
%doc README.md INSTALL.md ChangeLog NEWS AUTHORS THANKS
%{_sbindir}/backup-manager
%{_bindir}/backup-manager-purge
%{_bindir}/backup-manager-upload
%{_datadir}/backup-manager/backup-manager.conf.tpl
%config(noreplace) %{_sysconfdir}/backup-manager.conf
%{_sysconfdir}/cron.daily/backup-manager
%{bm_libdir}/*.sh
%{bm_contribdir}/*.sh
%{perl_vendorlib}/BackupManager/*.pm
%{_mandir}/man8/backup-manager*.8*
%{_datadir}/locale/*/LC_MESSAGES/backup-manager.mo

%changelog
* Fri Oct 04 2024 Pablo Canto - 0.7.18-1
- RPM packaging for RHEL/Rocky
- Install default config and cron.daily script
