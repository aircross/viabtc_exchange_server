#!/usr/bin/env bash
set -e
basepath=$(cd `dirname $0`; pwd)
projectpath=$(dirname $basepath)
echo $basepath
echo $projectpath

#function install(){
#    if [ $1 = "accesshttp" ]; then
#        echo 1
#    elif [ $1 = "accessws" ] ; then
#        echo 1
#    elif [ $1 = "alert" ] ; then
#        echo 1
#    elif [ $1 = "marketprice" ] ; then
#        echo 1
#    elif [ $1 = "matchengine" ] ; then
#        echo 1
#    elif [ $1 = "readhistory" ] ; then
#        echo 1
#    elif [ $1 = "all" ] ; then
#        ./install_depends.sh
#
#    else
#        echo "A command that cannot be understood"
#    fi
#}
#
#function uninstall(){
#    echo 1
#}
#
#if [ $1 = "install" ]; then
#    install $2
#elif [ $1 = "accessws" ] ; then
#    uninstall $2
#else
#echo 222
#fi
#
#echo "process start $1 $2"
#install "dddd" "xxxx"