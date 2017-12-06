#!/usr/bin/env bash
set -e
basepath=$(cd `dirname $0`; pwd)
projectpath=$(dirname $basepath)

function install(){
    processArray=("accesshttp" "accessws" "alertcenter" "marketprice" "matchengine" "readhistory" )
      for process in ${processArray[@]}
        do
            if [ $1 = process ]; then
                ./install_depends.sh
                echo "begin compile $1"
                cd $projectpath/$process
                make -j4
                return 0
            fi
        done

    if [ $1 = "all" ] ; then
        ./install_depends.sh
        echo "./install_depends.sh end"
        for process in ${processArray[@]}
        do
            cd $projectpath/$process
            make -j4
        done
        return 0
    fi

    echo "A command that cannot be understood"
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
