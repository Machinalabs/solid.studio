#! /bin/bash

action="start"
command="unknown"

usage(){
    echo "usage..."
}

setup(){
    echo "Starting initial setup"

    git submodule init

    git submodule update

    setup_desktop

    setup_web

    setup_monorepo
}

setup_desktop(){
    echo "Setting up desktop project"

    cd solid.desktop 

    git checkout master

    git pull

    npm install
}

setup_web(){
    echo "Setting up web project"

    cd solid.web 

    git checkout master

    git pull

    npm install
}

setup_monorepo(){
    echo "Setting up monorepo project"

    cd solid.monorepo 

    git checkout master

    git pull

    npm install
}

start_desktop(){
    echo "Starting desktop project"

    cd solid.desktop 

    npm start
}

start_web(){
    echo "Starting web project"

    cd solid.web 

    npm start
}

start(){
     if [ "$command" = "desktop" ]; then
        echo "Starting desktop project"
        start_desktop
    elif [ "$command" = "web" ]; then
        echo "Starting web project"
        start_web
    else 
        echo "Unknown command"
    fi
}

while [ "$1" != "" ]; do
    case $1 in
        setup | --setup )       action="setup"
                                ;;
        start | --start )       shift
                                action="start"
                                command=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$action" = "setup" ]; then
    setup
elif [ "$action" = "start" ]; then
    start
else
    usage
fi