# chk_mode_ext_script.sh

## Purpose

This Bash script scans a directory for files starting with a Bash shebang (`#!/bin/bash`) and ensures:

1. Permissions are set to `744`.
2. File extensions are `.sh`.

It helps maintain consistency and security for executable scripts in a directory.

## Usage

```bash
./chk_mode_ext_script.sh [DIRECTORY]

•	DIRECTORY (optional): Path to the directory to process. Defaults to the current working directory.
•	Only regular files with a Bash shebang are processed.
•	Directories and symlinks are skipped.

Example

./chk_mode_ext_script.sh ~/bin/bash-scripts

This will scan all files in ~/bin/bash-scripts, set the correct permissions, and rename files missing the .sh extension.

Notes
	•	The script is safe to run multiple times.
	•	Output indicates any changes made to permissions or filenames.
	•	Written and maintained by Anil Pandit, Feb 2026.

