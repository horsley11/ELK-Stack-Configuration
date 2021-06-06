#!/bin/bash

grep $1 0312* | awk '{print $1,$2,$5,$6}' | grep -i $2

