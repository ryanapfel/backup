#!/usr/bin/env bash


print_disk_usage() {
    echo 'Backup Locations'
	du -sh "${full_backup_path}/full/"
	du -sh "${daily_backup_path}/daily"
	echo
}



source='/Users/ryanapfel/Documents/UCLA/spreadsheets'
full_backup_path='/Users/ryanapfel/Documents/UCLA/backup'
daily_backup_path='/Users/ryanapfel/Documents/UCLA/backup'
log_path='/Users/ryanapfel/Documents/UCLA/backup_script/logs.txt'

script_name="${0##*/}"
SECONDS=0
start_time="$(date +%Y.%m.%d)"
exec 3>&1 1>>${log_path} 2>&1
daily_dir="${daily_backup_path}/daily/${start_time}"
full_dir="${full_backup_path}/full"



echo '============================================='
echo 'Backup on '${start_time}

print_disk_usage


mkdir -p "${full_dir}"

echo 'RSYNC Output:'
rsync --archive --delete --backup  --verbose \
--backup-dir='${daily_dir}' \
${source} \
${full_dir}

echo '============================================='

exit 0
