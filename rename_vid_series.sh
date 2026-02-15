#!/bin/bash 

# Rename video files to a standard format 
# Author: Anil Pandit, 01/2026

usage () {
    echo "usage: '${0##*/}' DIRECTORY" >&2
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

# Ask the user for the title of the video
echo "This script renames video files to a standard format. Ensure the folder contains one series only."
read -r -p "Enter the title of the series > "       # note: '-r' is "raw" mode. Doesn't interpret backslash escapes 

# Convert spaces in the title to underscores
if [[ $REPLY ]]; then
    title=${REPLY// /_}
else
    echo "Invalid response" >&2
    exit 1
fi

# Initialize the year prompt flag and default year
year_prompted=false
default_year=""

# Loop through the directory, protecting against empty directories
shopt -s nullglob
for f in "$dirname"/*; do

    # Skip directories
    [[ -d $f ]] && continue

    # Normalise the filename to lowercase
    f_lc=${f,,}

    # Process known video extensions
    if [[ $f_lc =~ \.(mp4|mov|avi|mkv)$ ]]; then

        # Check if the filename contains a year
        if [[ $f =~ (^|[^0-9])((19|20)[0-9]{2})([^0-9]|$) ]]; then
            year="${BASH_REMATCH[2]}"

        # For the first file without a year, ask the user    
        elif [[ ! $year_prompted ]]; then
            read -r -p "Title doesn't contain a year. Enter YYYY or leave blank > " year
            year_prompted=true
            default_year=$year

            # Validate input
            if [[ -n $year && ! $year =~ ^(19|20)[0-9]{2}$ ]]; then
                 echo "Invalid year format. Leaving blank."
                 year=""
                 default_year=""
            fi
        else

            # Use the previously entered default year for remaining files
            year=$default_year
        fi

        # Check for episodic format
        if [[ $f_lc =~ s[^0-9]*([0-9]{1,2})[^0-9]*e[^0-9]*([0-9]{1,2}) ]]; then

            # Extract the season and episode numbers (forcing decimal conversion,
            # so that leading zeroes aren't treated as octal numbers)
            season=$(printf "%02d" "$((10#${BASH_REMATCH[1]}))")
            episode=$(printf "%02d" "$((10#${BASH_REMATCH[2]}))")

            # Construct new filename 
            oldname=${f##*/}
            ext=${f_lc##*.}             
            newname="${title}_${year}_S${season}_E${episode}.${ext}"
            
            # Check if the new filename already exists before renaming 
            if [[ -e "$dirname/$newname" ]]; then
                echo "Error: File $newname already exists. Skipping renaming for '$oldname'." >&2
                continue
            else
                mv -- "$f" "$dirname/$newname"
                echo "Renamed $oldname --> $newname"
            fi
        else
            echo "Skipping: no season/episode pattern in $f" >&2 
        fi
    fi
done
shopt -u nullglob
