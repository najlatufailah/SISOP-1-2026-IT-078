#!/bin/bash

input="gsxtrack.json"
output="titik-penting.txt"

awk '
/"site_name"/ {
    split($0, a, ": ")
    gsub(/[",]/, "", a[2])
    site=a[2]
}

/"coordinates"/ {
    match($0, /\[.*\]/)
    coords=substr($0, RSTART+1, RLENGTH-2)
    split(coords, c, ",")
    lon=c[1]
    lat=c[2]

    gsub(/ /, "", lat)
    gsub(/ /, "", lon)

    printf "node_%03d,%s,%s,%s\n", ++i, site, lat, lon
}
' $input > $output

echo "Berhasil parsing koordinat!"
