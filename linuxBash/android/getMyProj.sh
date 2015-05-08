#!/bin/bash

myGITProjList=(Email UnifiedEmail Exchange)
prfixPATH="ssh://bluepupu@192.168.8.123:29418/android/packages/apps/"
currentBranch=$1

if [ "$currentBranch" == "" ];then
    currentBranch="ABC/8974/1234/PFAL"    
fi

echo "BRANCH: $currentBranch"

for GIT_PRJ in "${myGITProjList[@]}";
do
    currentSSH=$prfixPATH$GIT_PRJ
    echo "SSH Path: $currentSSH"
    git clone $currentSSH -b $currentBranch
    cd $GIT_PRJ
    
    git config user.name bluepupu
    git config user.email bluepupu@noreply-github.com
    cd ../
done
