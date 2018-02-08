#!/bin/bash
set -e

CHROOTDIR="./base"
MIRROR="http://nl.alpinelinux.org/alpine"
VERSION="latest-stable"

APKTOOLS=$(curl ${MIRROR}/${VERSION}/main/x86_64/ 2>/dev/null | grep apk-tools-static | sed 's#.*href="##;s#">.*##')

# Fetch apk-tools
curl ${MIRROR}/${VERSION}/main/x86_64/${APKTOOLS} -o ${APKTOOLS}

tar xf ${APKTOOLS}

[[ -d ${CHROOTDIR} ]] && rm -rf ${CHROOTDIR}
mkdir ${CHROOTDIR}
./sbin/apk.static -X ${MIRROR}/${VERSION}/main -U --allow-untrusted --root ${CHROOTDIR} --initdb add alpine-base

echo "${MIRROR}/${VERSION}/main" > ${CHROOTDIR}/etc/apk/repositories
echo "${MIRROR}/${VERSION}/community" >> ${CHROOTDIR}/etc/apk/repositories
rm -rf ${CHROOTDIR}/var/cache/apk/*

[[ -e alpine_base.tar ]] && rm -f alpine_base.tar

cd ${CHROOTDIR}
tar cf ../alpine_base.tar .
