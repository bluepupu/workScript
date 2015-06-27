#!/bin/bash


#  Patch the same filename from file has been modified
#  Author : WenYang
#  Create: 2015-06-27


NOPATCH_SOURCE_DIR=$1
JAVA_RELATIVE_FILE_NAME=$2
PATCH_NAME=`date +%s`".patch"


if [ "$NOPATCH_SOURCE_DIR" == "" ] || [ "$JAVA_RELATIVE_FILE_NAME" == "" ];then
	echo "mypatch.sh <NOPATCH_SOURCE_DIR> <JAVA_RELATIVE_FILE_NAME>"

fi

echo "--------------------------------------------------------"
echo "NOPATCH_SOURCE_DIR: $NOPATCH_SOURCE_DIR"
echo "JAVA_RELATIVE_FILE_NAME: $JAVA_RELATIVE_FILE_NAME" 
echo "PATCH_NAME: $PATCH_NAME"
echo "--------------------------------------------------------"

diff -urN $NOPATCH_SOURCE_DIR/$JAVA_RELATIVE_FILE_NAME $JAVA_RELATIVE_FILE_NAME > $PATCH_NAME

patch < $PATCH_NAME $NOPATCH_SOURCE_DIR/$JAVA_RELATIVE_FILE_NAME

echo "Done..."
echo "$NOPATCH_SOURCE_DIR/$JAVA_RELATIVE_FILE_NAME has patched!!!"

