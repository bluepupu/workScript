#!/bin/sh

# APPI Dailybuild script 
#
# Author: WenYang
# Created Date: 2015/08/31
# Version: 1.0
#
# To DO List: (1)add changing FIH serial number
#                       (2)Auto-change email version



ROOT_DIR=`cd ..;pwd`
SCRIPT_DIR=`pwd`
APP_RELTIVE_DIR="LINUX/LINUX/android/packages/apps"
EMAIL_PRJ_DIR="$ROOT_DIR/Email_APPI"
EMAIL_GIT_PRJS=(Email Exchange)
EMAIL_PACKAGE_LISTS=(Email UnifiedEmail Exchange)


function traceLog(){
	local TRACE=true
    
	if $TRACE; then 
		echo -e `date "+%Y-%m-%d %H:%M:%S"` $1
	fi
}

function doLog(){
		echo -e $1
}

function debugLog(){
	local DEBUG=true
    
	if $DEBUG; then 
		echo -e $1
	fi
}


debugLog "Root dir: $ROOT_DIR"
debugLog "Script dir: $SCRIPT_DIR"

function doSyncAPP(){
	traceLog "[begin]Sync Email App..."
	
	for CUR_PRJ in "${EMAIL_GIT_PRJS[@]}"
	do
		traceLog "Sync Project: $CUR_PRJ"
		doLog "-------------------------------------------"
		cd $EMAIL_PRJ_DIR/$CUR_PRJ
		git pull
		doLog "\n\n\n\n"
	done
        	
	traceLog "[end]Sync Email App...\n"
}

function deployAPP(){
	traceLog "=>Remove old APP source files ..."

	for CUR in "${EMAIL_PACKAGE_LISTS[@]}"
	do
		traceLog "[*]remove '$CUR'.. "
		rm -rf $ROOT_DIR/$APP_RELTIVE_DIR/$CUR
	done

    traceLog "=>Deploy Email APPI source files to codebase ..."
	for CUR in "${EMAIL_GIT_PRJS[@]}"
	do
		traceLog "[*]copy '$CUR' to codebase... "
		if [ "$CUR" == "Email" ]; then			
			cp -r $EMAIL_PRJ_DIR/$CUR/Email $ROOT_DIR/$APP_RELTIVE_DIR/
			cp -r $EMAIL_PRJ_DIR/$CUR/UnifiedEmail $ROOT_DIR/$APP_RELTIVE_DIR/
		else
			cp -r $EMAIL_PRJ_DIR/$CUR $ROOT_DIR/$APP_RELTIVE_DIR/
		fi
                
    done
	
    traceLog "=>Running build APK process and deploy it ..."
    
    #filename 
    local DOC_VERSION="V1.2"
    local ANDROID_VERSION="5.0"
    local APK_VERSION="5.1050.01"
    local FILENAME_VERSION="_FIH_"$DOC_VERSION"_"$ANDROID_VERSION"_"$APK_VERSION
    #path
    local APP_ABSOLUTE_DIR=$ROOT_DIR/$APP_RELTIVE_DIR
    local ANDROID_ABSOLUTE_DIR=$ROOT_DIR/LINUX/LINUX/android
    local APK_OUT_DIR=$ANDROID_ABSOLUTE_DIR/out/target/product/VNA/system/app
    local TARGET_DIR=/home/fihtdc/Workspace2/Email/Release_APK/$APK_VERSION

    debugLog "[1]DOC_VERSION: $DOC_VERSION"
    debugLog "[2]ANDROID_VERSION: $ANDROID_VERSION"
    debugLog "[3]APK_VERSION: $APK_VERSION"
    debugLog "[4]FILENAME_VERSION: $FILENAME_VERSION"
    debugLog "[5]APP_ABSOLUTE_DIR: $APP_ABSOLUTE_DIR"
    debugLog "[6]ANDROID_ABSOLUTE_DIR: $ANDROID_ABSOLUTE_DIR"
    debugLog "[7]APK_OUT_DIR: $APK_OUT_DIR"
    debugLog "[8]TARGET_DIR: $TARGET_DIR"

    cd $ANDROID_ABSOLUTE_DIR
    source build/envsetup.sh
    choosecombo 1 VNA_0001_FIH 1

    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
    export JAVA_HOME

    PATH=$JAVA_HOME/bin:$PATH

    traceLog "Remove the old apk in 'out' directory ..."
    rm -f $APK_OUT_DIR/Email/*
    rm -f $APK_OUT_DIR/Exchange2/*

    traceLog "[start] Module build APK..."
    cd $APP_ABSOLUTE_DIR/Email
    mm -B

    cd $APP_ABSOLUTE_DIR/Exchange
    mm -B
    traceLog "[end] Module build APK..."
    
    if [ ! -d "$TARGET_DIR" ];then
        mkdir $TARGET_DIR
    else
        traceLog "$TARGET_DIR has been created!!!"
    fi

    cp -v $APK_OUT_DIR/Email/Email.apk $TARGET_DIR/Email$FILENAME_VERSION.apk
    cp -v $APK_OUT_DIR/Exchange2/Exchange2.apk $TARGET_DIR/Exchange2$FILENAME_VERSION.apk
    
}

#----main----
doSyncAPP
deployAPP
