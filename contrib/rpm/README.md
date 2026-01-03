RPM build instructions
======================

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
