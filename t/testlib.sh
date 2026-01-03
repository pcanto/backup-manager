
# Load the backup-manager's library
locallib="../lib"
libdir="$locallib"
source $locallib/externals.sh
source $locallib/gettext.sh
source $locallib/logger.sh
source $locallib/dialog.sh
source $locallib/files.sh
source $locallib/md5sum.sh
source $locallib/backup-methods.sh
source $locallib/upload-methods.sh
source $locallib/burning-methods.sh
source $locallib/actions.sh
source $locallib/dbus.sh

VERSION="0.7.1+svn"

# external programs (cannot be sure where they are)
zip=$(bm_find_executable zip) || true
bzip=$(bm_find_executable bzip2) || true
gzip=$(bm_find_executable gzip) || true
gpg=$(bm_find_executable gpg) || true
xz=$(bm_find_executable xz) || true
zstd=$(bm_find_executable zstd) || true
lzma=$(bm_find_executable lzma) || true
dar=$(bm_find_executable dar) || true
tar=$(bm_find_executable tar) || true
rsync=$(bm_find_executable rsync) || true
mkisofs=$(bm_find_executable mkisofs) || mkisofs=$(bm_find_executable genisoimage) || true
xorriso=$(bm_find_executable xorriso) || true
if [[ -z "$mkisofs" ]] && [[ -n "$xorriso" ]]; then
    mkisofs="$xorriso -as mkisofs"
fi
growisofs=$(bm_find_executable growisofs) || true
dvdrwformat=$(bm_find_executable dvd+rw-format) || true
cdrskin=$(bm_find_executable cdrskin) || true
cdrecord=$(bm_find_executable cdrecord) || cdrecord=$(bm_find_executable wodim) || true
if [[ -z "$cdrecord" ]] && [[ -n "$cdrskin" ]]; then
    cdrecord="$cdrskin"
fi
md5sum=$(bm_find_executable md5sum) || true
bc=$(bm_find_executable bc) || true
mysqldump=$(bm_find_executable mysqldump) || true
mariadbdump=$(bm_find_executable mariadb-dump) || true
svnadmin=$(bm_find_executable svnadmin) || true
logger=$(bm_find_executable logger) || true

# Find which lockfile to use
# If we are called by an unprivileged user, use a lockfile inside the user's home;
# else, use /var/run/backup-manager.lock
systemlockfile="/var/run/backup-manager.lock"
userlockfile="$HOME/.backup-manager.lock"
if [[ "$UID" != 0 ]]; then
    lockfile="$userlockfile"
else
    lockfile="$systemlockfile"
fi

libdir="../lib"
bmu="perl -I.. ../backup-manager-upload"
bmp="perl -I.. ../backup-manager-purge"

conffile="confs/base.conf"
version="false"
force="false"
upload="false"
burn="false"
help="false"
md5check="false"
purge="false"
warnings="false"
verbose="false"

bm_dbus_init
