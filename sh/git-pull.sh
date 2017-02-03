#!/bin/bash

# Parse options
while getopts ":n:u:" opt; do
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
git pull $REPO_URL