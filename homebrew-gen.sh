#!/bin/bash

TEMPLATE="cloudera-boot.rb.tpl"

usageAndExit() {
  echo "Usage: $0 -v <version> -d <archive_dir>" >&2
  exit 1
}

while getopts "v:d:" opt; do
  case $opt in
    v)
      VERSION=$OPTARG
      ;;
    d)
      ARCHIVE_DIR=$OPTARG
      ;;
    \?)
      usageAndExit
      ;;
    :)
      usageAndExit
      ;;
  esac
done

[ -z "${VERSION}" ] && usageAndExit
[ -z "${ARCHIVE_DIR}" ] && usageAndExit

ARTIFACT="cloudera-boot-${VERSION}.tar.gz"

# create a artifact first
tar zcf ${ARCHIVE_DIR}/${ARTIFACT} homebrew
SHA256=$(shasum -a 256 ${ARCHIVE_DIR}/${ARTIFACT} | awk '{printf $1}')

cat ${TEMPLATE} \
| sed "s/\${ARTIFACT}/${ARTIFACT}/g" \
| sed "s/\${SHA256}/${SHA256}/g" \
| sed "s/\${VERSION}/${VERSION}/g"
