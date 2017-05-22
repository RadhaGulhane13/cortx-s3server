#!/bin/sh

set -e
abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "Error encountered. Precheck failed..." >&2
    trap : 0
    exit 1
}
trap 'abort' 0

JCLIENTJAR='jclient.jar'
JCLOUDJAR='jcloudclient.jar'

S3CMD_LOC=/usr/local/seagate/s3cmd/
MERO_ST=mero_st/bin/
if [ -f $S3CMD_LOC/s3cmd ] ;then
    cp $S3CMD_LOC/s3cmd $MERO_ST
    cp -rf $S3CMD_LOC/S3 $MERO_ST
    printf "\nCheck S3CMD...OK"
else
    printf "\nCheck $S3CMD_LOC ...Not found"
    abort
fi
if [ -f $JCLIENTJAR ] ;then
    printf "\nCheck $JCLIENTJAR...OK"
else
    printf "\nCheck $JCLIENTJAR...Not found"
    abort
fi
if [ -f $JCLOUDJAR ] ;then
    printf "\nCheck $JCLOUDJAR...OK"
else
    printf "\nCheck $JCLOUDJAR...Not found"
    abort
fi
printf "\nCheck seagate host entries for system test..."
getent hosts seagatebucket.s3.seagate.com seagate-bucket.s3.seagate.com >/dev/null
getent hosts seagatebucket123.s3.seagate.com seagate.bucket.s3.seagate.com >/dev/null
getent hosts iam.seagate.com sts.seagate.com >/dev/null
printf "OK \n"

trap : 0
