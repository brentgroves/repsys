#!/bin/bash

function area() {
  echo "$1 + $1 * 3.14159" | bc
}

result=$(area 5.1)
echo "The area is: $result"

