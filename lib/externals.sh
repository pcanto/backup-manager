# All external programs used must be initialized here
function bm_find_executable()
{
    command -v "$1" 2>/dev/null
}

if [[ -n "${GZIP:-}" ]]; then
    unset GZIP
fi

zip=$(bm_find_executable zip) || true
bzip=$(bm_find_executable bzip2) || true
pbzip2=$(bm_find_executable pbzip2) || true
gzip=$(bm_find_executable gzip) || true
gpg=$(bm_find_executable gpg) || true
xz=$(bm_find_executable xz) || true
zstd=$(bm_find_executable zstd) || true
lzma=$(bm_find_executable lzma) || true
dar=$(bm_find_executable dar) || true
tar=$(bm_find_executable tar) || true
rsync=$(bm_find_executable rsync) || true
rclone=$(bm_find_executable rclone) || true
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
mysql=$(bm_find_executable mysql) || true
mariadbdump=$(bm_find_executable mariadb-dump) || true
mariadb=$(bm_find_executable mariadb) || true
pgdump=$(bm_find_executable pg_dump) || true
svnadmin=$(bm_find_executable svnadmin) || true
logger=$(bm_find_executable logger) || true
nice_bin=$(bm_find_executable nice) || true
dd=$(bm_find_executable dd) || true
mongodump=$(bm_find_executable mongodump) || true
mongo=$(bm_find_executable mongo) || true
mongosh=$(bm_find_executable mongosh) || true
