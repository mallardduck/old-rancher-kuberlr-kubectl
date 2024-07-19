#!/usr/bin/env bash
set -e

: "${IMAGE_REPO:=rancher/kubectl}"
: "${EXISTING_VERSIONS:=''}"

while IFS= read -r RELEASE_VERSION; do
  CHECK_VERSION="base-${RELEASE_VERSION}"
  echo "Checking if image ${IMAGE_REPO}:${CHECK_VERSION} exists"
  for EXISTING_VERSION in $EXISTING_VERSIONS; do
    if [ "$CHECK_VERSION" == "$EXISTING_VERSION" ]; then
      echo "Image ${IMAGE_REPO}:${CHECK_VERSION} already exists, skipping"
      continue 2
    fi
  done

  echo "Image ${IMAGE_REPO}:${CHECK_VERSION} does not exist, adding to new versions list"
  echo "${RELEASE_VERSION}" >> new-versions.txt
done < base/versions.txt
