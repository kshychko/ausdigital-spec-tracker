#!/bin/bash

# Parse options
while getopts ":n:u:t:r:" opt; do
    case $opt in
        n)
            REPO_NAME="${OPTARG}"
            ;;
        u)
            REPO_URL="${OPTARG}"
            ;;
        t)
            TARGET_REPO_NAME="${OPTARG}"
            ;;
        r)
            TARGET_REPO_URL="${OPTARG}"
            ;;
        \?)
            echo -e "\nInvalid option: -${OPTARG}"
            usage
            ;;
        :)
            echo -e "\nOption -${OPTARG} requires an argument"
            usage
            ;;
     esac
done
cd ~/opt
if [ -d "$TARGET_REPO_NAME" ]; then
    echo -e "${TARGET_REPO_NAME} exists, no need to clone"
    else
    git clone $TARGET_REPO_URL
fi

cd ~/opt/$TARGET_REPO_NAME
if [ -d "_specs" ]; then
    echo -e "specs directoryexists, no need to create"
    else
    mkdir "_specs"
fi

cd ~/opt/$TARGET_REPO_NAME/_specs
if [ -d "$REPO_NAME" ]; then
    echo -e "_specs/${REPO_NAME} directory exists, no need to create"
    else
    mkdir $REPO_NAME
fi

cd ~/opt/
if [ -d "$REPO_NAME" ]; then
    cd ~/opt/$REPO_NAME
    git pull origin master
    RESULT=$?
    if [[ ${RESULT} -ne 0 ]]; then
        echo -e "\nCan't pull ${REPO_URL} to ${REPO_NAME} repo"
        exit
    fi
    else
    git clone $REPO_URL
fi

cp -rf ~/opt/$REPO_NAME/docs/* ~/opt/$TARGET_REPO_NAME/_specs/$REPO_NAME/

cd ~/opt/$TARGET_REPO_NAME

git add --all

git commit -m "update specification files for ${REPO_NAME}"

git pull --rebase

git push origin master