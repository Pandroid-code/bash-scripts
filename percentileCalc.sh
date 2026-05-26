#!/bin/bash

# Author: Anil Pandit 05/2026
# calculate the 95th percentile of specified logs from a file of format:
# 20230322000441:Entity4:584:SUCCESS
# 20230322000441:Entity4:737:SUCCESS
# 20230322000441:Entity4:939:SUCCESS
# ...

usage () {
    echo "usage: '${0##*/}' Enter selection [0-4]" >&2
    exit 1
}

cat <<- _EOF_
Please Select:
    1. Filter logs by success
    2. Filter logs by success/hour
    3. Filter logs by success, Entity4 with response time > 1500
    4. Filter logs by success, Entity4 with response time > 1500/hour
    0. Quit
_EOF_

read -p "Enter selection [0-4] > "

case "$REPLY" in 
    1)
        # success
        awk '
        BEGIN{ FS = ":" }
        $4 == "SUCCESS" {
            # store response times
            count++
            values[count] = $3 

        }
        END{
            # sort numberically
            n = asort(values)

            # floor version
            # idx = int(0.95 * n)
            
            # ceiling version
            raw = 0.95 * n

            if (raw > int(raw))
                idx = int(raw) + 1
            else
                idx = raw

            # output percentile value
            print values[idx]

        }' interview2.log
       ;;
        
    2)
        # success, hourly 
        awk '
        BEGIN{ FS = ":" }
        $4 == "SUCCESS" {
            # store response times per hour
            hour = substr($1,1,10)
            values[hour] = values[hour] " " $3

        }
        END{
            for (h in values) {
                # split string into array
                n = split(values[h], arr, " ")

                # sort numerically
                asort(arr)

                # floor version
                # idx = int(0.95 * n)
                
                # ceiling version
                raw = 0.95 * n

                if (raw > int(raw))
                    idx = int(raw) + 1
                else 
                    idx = raw

                # print hour + percentile value
                print h ":" arr[idx]

                }
        }
        ' interview2.log
        ;;

    3)
        # success + Entity4 + >1500
        awk '
        BEGIN{ FS = ":" }                                           
        $2 == "Entity4" && $3 > 1500 && $4 == "SUCCESS" { 
            # store response times
            count++
            values[count] = $3

        }
        END{
            # sort numberically
            n = asort(values)

            # floor version
            # idx = int(0.95 * n)
            
            # ceiling version
            raw = 0.95 * n

            if (raw > int(raw))
                idx = int(raw) + 1
            else
                idx = raw

            # output percentile value                  
            print values[idx]               

        }' interview2.log
        ;;

    4)
        # success + Entity4 + >1500, hourly
        awk '
        BEGIN{ FS = ":" }
        $2 == "Entity4" && $3 > 1500 && $4 == "SUCCESS" {
            hour = substr($1,1,10)
            # store response times per hour
            values[hour] = values[hour] " " $3

        }
        END{
            for (h in values) {
                # split string into array
                n = split(values[h], arr, " ")

                # sort numerically
                asort(arr)

                # floor version
                # idx = int(0.95 * n)
                
                # ceiling version
                raw = 0.95 * n

                if (raw > int(raw))
                    idx = int(raw) + 1
                else
                    idx = raw

                # print hour + percentile value
                print h ":" arr[idx]
            }
        }
        ' interview2.log
        ;;

    0)
        exit
        ;;

    *)
        usage
        ;;

esac
