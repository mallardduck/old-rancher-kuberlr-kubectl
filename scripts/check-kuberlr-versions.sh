#!/usr/bin/env bash
set -e

VERSIONS_FILE="${1:-versions.txt}"
ARCHES="amd64 arm64 s390x"

while IFS= read -r release; do
    for arch in $ARCHES; do
      KUBERLR_URL="https://github.com/flavio/kuberlr/releases/download/${release}/kuberlr_${release:1}_linux_${arch}.tar.gz"
      echo "Checking if file exists at ${KUBERLR_URL}"
      curl --retry 10 --retry-connrefused -IL -o /dev/null -sS --fail "${KUBERLR_URL}"
    done
done < "$VERSIONS_FILE"

echo "All versions exists for ${ARCHES}"