Bash Scripts

A collection of Bash scripts demonstrating advanced Linux command-line and scripting skills.

rename_vid_series.sh

A Bash script to rename video files in a directory to a consistent format. This script showcases careful use of Bash builtins, globbing, regex, and parameter expansion, without relying on external tools where unnecessary.

Features
	•	Handles multiple video file extensions: .mp4, .mov, .avi, .mkv
	•	Normalizes filenames to lowercase
	•	Skips directories automatically
	•	Uses advanced Bash techniques, including extended globbing (extglob) and pattern matching
	•	Easily extendable to new filename patterns

Usage

./rename_vid_series.sh /path/to/videos

  •	Replace /path/to/videos with the directory containing your video files.
	•	The script will process all matching video files and rename them according to its rules.

Requirements
	•	Bash 4+ (or higher)
	•	Standard Linux utilities (mv, etc.)
	•	No additional dependencies

Notes
	•	Designed as a showcase of advanced Bash scripting concepts
	•	Illustrates efficient use of shell builtins instead of external tools
	•	Suitable for learning or adapting to other file-renaming taskskills

Example:
My.Show.S01E01.720p.MOV
My.Show.S01E02.720p.MOV
Another.Show.MOV

User enters the series title: My Show
User enters the year (if prompted): 2025

After running rename_vid_series.sh:

My_Show_2025_S01_E01.mov
My_Show_2025_S01_E02.mov
Skipping: no season/episode pattern in /path/to/Another.Show.MOV

Demonstrates how the script normalizes filenames, applies season/episode numbering, adds the year, converts to lowercase, and skips files that don’t match the expected pattern.
