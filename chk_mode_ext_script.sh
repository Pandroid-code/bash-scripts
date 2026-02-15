#!/bin/bash

# Rename bash scripts with a '.sh' extension and change permissions to 744.
# Author: Anil Pandit 02/2026

usage () {
    echo "Usage: '${0##*/}' DIRECTORY" >&2
    exit 1
}

# Check for more than one argument
[[ $# -gt 1 ]] && usage

# Set the directory using the argument or a default value
dirname=${1:-$PWD}

# Remove any trailing "/" from dirname
dirname=${dirname%/}

# Ensure it's a directory	
[[ -d $dirname ]] || usage	

# Resolve to absolute path, avoiding all symlinks
dirname=$(cd "$dirname" && pwd -P ) || exit 1

# Loop through the directory, protecting against empty directories
shopt -s nullglob
for f in "$dirname"/*; do

    # Skip directories and symlinks
    [[ -d $f ]] || [[ -L $f ]] && continue

    # Extract the permissions
    old_mode=$(stat -c %a "$f")

    # Extract the base filename
    filename=${f##*/}

    # Check the file is a bash script and rename or change permissions if needed
    if grep --quiet --extended-regexp '^#! */bin/bash' "$f"; then
        if (( $old_mode != 744 )); then
            chmod 744 "$f"
            echo "Changed permissions for $filename: $old_mode --> 744"
        fi
        if [[ ! $f == *.sh$ ]]; then
            mv -- "$f" "${f%.*}.sh"
            echo "Renamed: $filename --> ${filename%.*}.sh"
        fi
    fi
done
shopt -u nullglob
