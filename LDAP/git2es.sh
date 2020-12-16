#!/bin/bash

set -e

DIR=${1?git2es.sh DIR URL}
shift
URL=${1?git2es.sh DIR URL}
shift

CURL_ARGS="$@"

function PUT {
  curl  --fail --request PUT --header "Content-Type: application/json" ${CURL_ARGS[@]} "$URL/$1" --data "@$DIR/$1"
  return $?
}

find "$DIR" -type f | sed -e "s;^$DIR/;;" | while read obj
do
  PUT "$obj"
done
