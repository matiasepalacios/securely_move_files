#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset

# set -o xtrace
# Set magic variables for current file & dir

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" 

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin # sets up the PATH
SOURCE=some_source_directory
DESTINATION=some_destination_directory

echo 'Script started at' $(date +"%D at %r")

move_files() {
	while read FILE; do
		if sudo rsync -Ravh "${FILE}" "${DESTINATION}" >> /dev/null
		then
			sudo rm "${FILE}";
			echo 'File ' "${FILE}" ' backed up in ' "${DESTINATION}"
		else
			echo 'failed to sync the file ' "${FILE}"
		fi
	done;
}

#use find to select the files that you want. In this case I'm backing up all files older than a week
find "${SOURCE}" -type f -mtime +7 | move_files;
