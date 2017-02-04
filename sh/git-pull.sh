#!/bin/bash

SPEC_TRACKER = "spec-tracker"
# Parse options
while getopts ":n:u:t" opt; do
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

cd ~/spec-tracker
if [ -d "$REPO_NAME" ]; then
    cd /$REPO_NAME
    git pull origin master
    RESULT=$?
    if [[ ${RESULT} -ne 0 ]]; then
        echo -e "\nCan't pull ${REPO_URL} to ${REPO_NAME} repo"
        exit
    fi
    else
    git clone $REPO_URL
fi

mkdir ~/spec-tracker/$TARGET_REPO_NAME/specs/$REPO_NAME/

cp -rf ~/spec-tracker/$REPO_NAME/docs/* ~/spec-tracker/$TARGET_REPO_NAME/specs/$REPO_NAME/

cd ~/spec-tracker/$TARGET_REPO_NAME

git add --all

git commit -m "update specification files for ${REPO_NAME}"

git pull --rebase

git push origin master