#!/usr/bin/env bash

echo "##[warning][Pre-Build Action] - Lets do some Pre build transformations..."

# Declare local script variables
SCRIPT_ERROR=0

# Define the files to manipulate
INFO_PLIST_FILE=${APPCENTER_SOURCE_DIRECTORY}/WczasyNadBialym/WczasyNadBialym/Info.plist

echo "##[warning][Pre-Build Action] - Checking if all files and environment variables are available..."
echo "##[warning][Pre-Build Action] - APPCENTER_SOURCE_DIRECTORY: $APPCENTER_SOURCE_DIRECTORY"


if [ -z "${APP_ID}" ]
then
    echo "##[error][Pre-Build Action] - APP_ID variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
    else
    echo "##[warning][Pre-Build Action] - APP_ID variable - oK!"
fi

if [ -z "${APP_CENTER_ID}" ]
then
    echo "##[error][Pre-Build Action] - APP_CENTER_ID variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
    else
    echo "##[warning][Pre-Build Action] - APP_CENTER_ID variable - oK!"
fi

if [ -e "${INFO_PLIST_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - Info.plist file found - oK!"
else
    echo "##[error][Pre-Build Action] - Info.plist file not found!"
    let "SCRIPT_ERROR += 1"
fi

######################## Changes on iOS
if [ -e "$INFO_PLIST_FILE" ]
then
    echo "##[command][Pre-Build Action] - Changing the App Id to: $APP_ID "
    plutil -replace "app_id" -string "$APP_ID" $INFO_PLIST_FILE

    echo "##[command][Pre-Build Action] - Changing the App Center Id to: $APP_CENTER_ID "
    plutil -replace "app_center_id" -string "$APP_CENTER_ID" $INFO_PLIST_FILE

    echo "##[section][Pre-Build Action] - Info.plist File content:"
    cat $INFO_PLIST_FILE
    echo "##[section][Pre-Build Action] - Info.plist EOF"
fi
