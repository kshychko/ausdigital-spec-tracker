#!/bin/bash

# Parse options
while getopts ":sn:su:tn:tu:" opt; do
    case $opt in
        n)
            REPO_NAME="${OPTARG}"
            ;;
        u)
            REPO_URL="${OPTARG}"
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

cd ~/spec-repos/$REPO_NAME
git pull
RESULT=$?
if [[ ${RESULT} -ne 0 ]]; then
    echo -e "\nCan't pull ${REPO_URL} to ${REPO_NAME} repo"
    exit
fi

cp -rf ~/spec-repos/$REPO_NAME/docs/* ~/spec-tracker/specs/ausdigital-syn/

cd ~/spec-tracker

git add --all

git commit -m "update specification files for ${REPO_NAME}"

git push origin master