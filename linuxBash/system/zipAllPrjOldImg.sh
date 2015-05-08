#!/bin/bash

#******************************************************
#
# Compress the image files of all directories
#
# Author: WenYang  2014/10
# 
#
#******************************************************




function compressModels() {

local models=`find ./ -maxdepth 1 -type d | sort -n`

OLD_IFS="$IFS"
IFS=$'\n'
local models_ary=($models)
IFS="$OLD_IFS"


models_ary_len=${#models_ary[@]}

for (( i=1; i<${models_ary_len}; i++ ))
do
	#echo "${models_ary[$i]}"
	local target_dir=${models_ary[$i]}
	local file_name=${target_dir//\.\//}
	
	if [ -d "$target_dir" ]; then
		echo "Compress $file_name ..."
		test -f ${file_name}.7z || 7z -mx9 a ${file_name}.7z $target_dir -xr\!*.zip
	        rm -rf $target_dir
        fi

done
}

function compressPrj() {
	#local versions=`find ./ -maxdepth 1 -type d -name "V*" -mtime +7 | sort -n`       
  local versions=`find ./ -maxdepth 1 -type d -name "V*" | sort -n`

	OLD_IFS="$IFS"
	IFS=$'\n'
	local versions_ary=($versions)
	IFS="$OLD_IFS"
	
	versions_ary_len=${#versions_ary[@]}
	
	#for (( i=1; i<${versions_ary_len}; i++ ))
	for i in `seq 0 $(($zip_version_count-1))`
	do
	        echo "-----------------------------------------------"
		echo "ary idx: $i / $(($zip_version_count-1))"
       	        local target_dir=${versions_ary[$i]}
	        local workdir_name=${target_dir//\.\//}
		echo "Workdir : $workdir_name"
		#TO DO: workdir_name == null, don't work
		cd $workdir_name
		#echo "PWD: `pwd`"		
		#sleep 5
		compressModels
		cd ../
		moveToBackupDir $workdir_name
	done
	fi
	
	echo "No image need to be compressed"
}

function moveToBackupDir(){
	local compressedDir=$1
	local backupDir="`pwd`/previous_images"
        test -d $backupDir || mkdir $backupDir
	mv $compressedDir $backupDir 
}


function mainWork() {
	MODEL_DIR=(LSO TID MC2 TX3)
	
	for CUR_PRJ in "${MODEL_DIR[@]}";
	do
		cd $CUR_PRJ
		echo "STRAT Compress project [$CUR_PRJ]..."
		echo "====================================================================================="
		compressPrj
		cd ..
		echo "END Compress project [$CUR_PRJ]..."
		echo "====================================================================================="
	done

}

mainWork




