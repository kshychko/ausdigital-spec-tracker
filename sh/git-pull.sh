#!/bin/bash

# Parse options
while getopts ":sn:su:tn:tu:" opt; do
    case $opt in
        sn)
            SOURCE_REPO_NAME="${OPTARG}"
            ;;
        su)
            SOURCE_REPO_URL="${OPTARG}"
            ;;
        tn)
            TARGET_REPO_NAME="${OPTARG}"
            ;;
        tu)
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

cd ~/spec-repos/$SOURCE_REPO_NAME
git pull $SOURCE_REPO_URL
RESULT=$?
if [[ ${RESULT} -ne 0 ]]; then
    echo -e "\nCan't pull ${SOURCE_REPO_URL} to ${SOURCE_REPO_NAME} repo"
    exit
fi

cp -rf ~/spec-repos/$SOURCE_REPO_NAME/docs/* ~/$TARGET_REPO_NAME/specs/$SOURCE_REPO_NAME/