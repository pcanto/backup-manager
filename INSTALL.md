Dependencies
------------

- If you want to enable the localisation, you need gettext.
- Perl is needed for FTP and SSH uploads.
- Rclone is needed for the rclone upload method.
- Everything else is written in Bash.

RHEL/Rocky dependencies
-----------------------

Base packages:

    dnf install -y gettext perl rsync gnupg2 bc zip bzip2 xz zstd tar openssh-clients

Optional packages by feature:

- Burning: xorriso dvd+rw-tools cdrskin
- S3: perl-Net-Amazon-S3
- FTPS: perl-Net-Lite-FTP (EPEL or CPAN)
- Rclone: rclone (EPEL)
- MySQL/MariaDB: mariadb (mariadb-dump) or mysql
- PostgreSQL: postgresql
- MongoDB: mongodb-org-tools (mongodump), mongosh (MongoDB repo)
- SVN: subversion
- DAR: dar

If you need EPEL packages:

    dnf install -y epel-release

Rocky Linux 9/10 notes
----------------------

- CD/DVD burning can use `xorriso` (mkisofs-compatible) and `cdrskin` if
  `mkisofs`/`cdrecord` are not present. Install `xorriso` and `dvd+rw-tools`
  if you need burning support.
- MongoDB database listing supports `mongosh` as a replacement for the legacy
  `mongo` shell.


How to install backup-manager
-----------------------------

    sudo make install
    sudo cp /usr/share/backup-manager/backup-manager.conf.tpl /etc/backup-manager.conf

You can then edit `/etc/backup-manager.conf` to fit your needs.

Please refer to the wiki for details:
https://github.com/sukria/Backup-Manager/wiki

RPM packaging (RHEL/Rocky)
--------------------------

1) Install build tools:

    dnf install -y rpm-build rpmdevtools make gettext perl

2) Create a source tarball:

    VERSION=$(cat VERSION)
    git archive --prefix=backup-manager-$VERSION/ -o backup-manager-$VERSION.tar.gz HEAD

3) Build the RPM:

    rpmdev-setuptree
    cp backup-manager-$VERSION.tar.gz ~/rpmbuild/SOURCES/
    cp contrib/rpm/backup-manager.spec ~/rpmbuild/SPECS/
    rpmbuild -ba ~/rpmbuild/SPECS/backup-manager.spec

The RPM installs a default config at /etc/backup-manager.conf (noreplace)
and a cron script at /etc/cron.daily/backup-manager.


For Apple macOS with Fink
-------------------------

1) Install Fink.
   http://www.finkproject.org/

2) Download Backup-Manager:

    curl -L https://github.com/sukria/Backup-Manager/archive/0.7.15.zip > ~/Desktop/Backup-manager-0.7.15.zip
    cd ~/Desktop
    unzip backup-manager-0.7.15.zip
    cd Backup-Manager-0.7.15

3) Then "make install", and install the needed packages asked by Fink,
as all the needed packages are not installed with the basic Fink install.

    make install -e FINK=/sw

4) After complete install, copy, edit the `backup-manager.conf` file:

    cp /usr/share/backup-manager/backup-manager.conf.tpl /etc/backup-manager.conf
    vim /etc/backup-manager.conf

5) Then you can start Backup Manager with:

    env PATH=/sw/lib/coreutils/bin:$PATH backup-manager -v

6) Backup Manager is now installed in `/usr/share/backup-manager`.
