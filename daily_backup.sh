#!/usr/bin/env bash


print_disk_usage() {
    echo 'Backup Locations'
	du -sh "${full_backup_path}/full/"
	du -sh "${daily_backup_path}/daily"
	echo
}



source='/Volumes/StrokeDropRAID/10-22-temp'
full_backup_path='/Volumes/18Drop/StrokeDropBackup'
daily_backup_path='/Volumes/18Drop/StrokeDropBackup'
log_path='/Volumes/18Drop/StrokeDropBackup/log/log.txt'

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
rsync --archive --delete --backup  \
--backup-dir=${daily_dir} \
${source} \
${full_dir}

end_time="$(date +%Y.%m.%d-%H.%M.%S)"
echo 'Completed on:' ${end_time}

echo '============================================='

exit 0
