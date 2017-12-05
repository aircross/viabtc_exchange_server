#!/usr/bin/env bash
set -e
basepath=$(cd `dirname $0`; pwd)
projectpath=$(dirname $basepath)

function install(){
    if [ $1 = "accesshttp" ]; then
        echo 1
    elif [ $1 = "accessws" ] ; then
        echo 1
    elif [ $1 = "alertcenter" ] ; then
        echo 1
    elif [ $1 = "marketprice" ] ; then
        echo 1
    elif [ $1 = "matchengine" ] ; then
        echo 1
    elif [ $1 = "readhistory" ] ; then
        echo 1
    elif [ $1 = "all" ] ; then
        processArray=("accesshttp" "accessws" "alertcenter" "marketprice" "matchengine" "readhistory")
        ./install_depends.sh
        echo "./install_depends.sh end"
        for process in ${processArray[@]}
        do
            cd $projectpath/process
            make -j4
        done
    else
        echo "A command that cannot be understood"
    fi
}

function uninstall(){
    echo 1
}

if [ $1 = "install" ]; then
    install $2
elif [ $1 = "install" ] ; then
    uninstall $2
else
    echo "不知道的指令"
fi
