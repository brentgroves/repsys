#!/bin/bash

function add() {
  local sum=$(( $1 + $2 ))
  echo "$sum"
}

# Example usage:
result=$(add 5 10)
echo "The sum is: $result"
