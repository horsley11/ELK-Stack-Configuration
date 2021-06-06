#!/bin/bash

cat $1 | grep $2 | grep -i $3 | awk '{print $1,$2,$5,$6}'

