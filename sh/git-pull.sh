#!/bin/bash

# Parse options
while getopts ":u:" opt; do
    case $opt in
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

cd ~/spec-repos
git clone $REPO_URL