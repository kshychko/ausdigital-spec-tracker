#!/bin/bash

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

rm -rf ~/$TARGET_REPO_NAME

cd ~/

git clone $TARGET_REPO_URL

cd ~/spec-repos/$REPO_NAME
git pull origin master
RESULT=$?
if [[ ${RESULT} -ne 0 ]]; then
    echo -e "\nCan't pull ${REPO_URL} to ${REPO_NAME} repo"
    exit
fi

mkdir ~/$TARGET_REPO_NAME/specs/$REPO_NAME/

cp -rf ~/spec-repos/$REPO_NAME/docs/* ~/$TARGET_REPO_NAME/specs/$REPO_NAME/

cd ~/$TARGET_REPO_NAME

git add --all

git commit -m "update specification files for ${REPO_NAME}"

git pull --rebase

git push origin master