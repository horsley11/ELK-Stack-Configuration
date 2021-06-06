#Shell script written to determine when a dealer is working on a specific day and at a specific time.
#!/bin/bash

cat $1 | grep $2 | grep -i $3 | awk '{print $1,$2,$5,$6}'

