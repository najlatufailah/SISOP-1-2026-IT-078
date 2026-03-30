#!/bin/bash

input="titik-penting.txt"
output="posisipusaka.txt"

p1=$(head -n 1 $input)
p2=$(tail -n 1 $input)

lat1=$(echo $p1 | cut -d',' -f3)
lon1=$(echo $p1 | cut -d',' -f4)

lat2=$(echo $p2 | cut -d',' -f3)
lon2=$(echo $p2 | cut -d',' -f4)

lat_mid=$(echo "($lat1 + $lat2)/2" | bc -l)
lon_mid=$(echo "($lon1 + $lon2)/2" | bc -l)

echo "$lat_mid,$lon_mid" > $output

echo "Koordinat pusat:"
cat $output
