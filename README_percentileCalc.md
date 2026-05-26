# percentileCalc.sh

A Bash/AWK script to calculate 95th percentile response times from structured log data.

The script processes log files in the following format:

20230322000441:Entity4:584:SUCCESS
20230322000441:Entity4:737:SUCCESS
20230322000441:Entity4:939:SUCCESS

The script supports:

- Calculating the 95th percentile for successful requests
- Grouping percentile calculations by hour
- Filtering by entity name
- Filtering by minimum response time threshold

## Features

- Written using Bash and AWK
- Uses AWK arrays and sorting for percentile calculations
- Implements the nearest-rank percentile method
- Menu-driven CLI interface
- Designed for Linux command-line environments

## Usage

Make the script executable:

chmod +x percentileCalc.sh

Run the script:

./percentileCalc.sh

You will then be prompted to select one of the available filtering/reporting options.

## Notes

- Developed and tested on Linux
- Intended as a lightweight operational log-analysis utility
- Designed to avoid external dependencies beyond standard Linux tooling



