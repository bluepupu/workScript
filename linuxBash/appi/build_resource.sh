#!/bin/sh

#/home/fihtdc/Workspace2/Email/[APPI]Preload_Resource

ROOT_DIR=`pwd`
APK_VER=$1


if [ "$1" == "" ]; then
	echo "Please specify the APK version...  ./build_resource.sh <APK Version>"
        exit -1
fi


if [ !-d "$ROOT_DIR/$APK_VER" ]; then
	echo "The directory $APK_VER doesn't exists!!!"
	exit -1
fi

rm -rvf $ROOT_DIR/*.zip

cd $ROOT_DIR/$APK_VER/Email
#7z a \-tzip Preload.App.Resource.zip Preload.App.Resource/
zip -r ../../Preload.App.Resource.zip Preload.App.Resource/
#mv $ROOT_DIR/$APK_VER/Email/*.zip $ROOT_DIR/



cd $ROOT_DIR/$APK_VER/Exchange
#7z a \-tzip Preload.App.Resource\(Exchange\).zip Preload.App.Resource/
zip -r ../../Preload.App.Resource\(Exchange\).zip Preload.App.Resource/
#mv $ROOT_DIR/$APK_VER/Exchange/*.zip $ROOT_DIR/
