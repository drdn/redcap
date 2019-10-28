#!/bin/bash

########################################################################################
# Script Name:  lock-record.sh
# Description:  Makes a call to a redcap instance to programmatically perform a
#               lock/unlock/status action for provided record ids.              
# Dependencies: Requires the external module 'locking_api'. External module
#               documentation located at: https://github.com/lsgs/redcap-locking-api/
# Arguments:    Requires config.txt and ids.txt located in the same directory as the
#               script.
#               Config.txt should have a valid project API Token on line 1 and a valid
#               REDCap endpoint on line 2.
#               Ids.txt should be a list of valid record ids on separate lines for which 
#               to perform the lock/unlock/status action.
# Author:       David Durden
# Email:        durden AT umd DOT edu 
########################################################################################

# Set api token
TOKEN=$( sed -n 1p config.txt )
URL=$( sed -n 2p config.txt )
FORM="?NOAUTH&type=module&prefix=locking_api&page="

# Set api form string
DATA="token="$TOKEN"&returnFormat=csv&record="

read -p "Select an action to perform for all records in ids.txt:
    L for 'lock'
    U for 'unlock'
    S for 'status'
    Q to quit
    Selction: " ANSWER

while true
do
    case $ANSWER in
        [Ll]* ) echo "Locking records"
            while read LINE
                do curl -v -d $DATA$LINE $URL$FORM"lock"
            done < ids.txt
            break;;

        [Uu]* ) echo "Unlocking records"
            while read LINE
                do curl -v -d $DATA$LINE $URL$FORM"unlock"
            done < ids.txt
            break;;

        [Ss]* ) echo "Checking lock status of records"
            while read LINE
                do curl -v -d $DATA$LINE $URL$FORM"status"
            done < ids.txt
            break;;

        [Qq]* ) echo "Exiting"
            exit;;

        * ) echo "Please re-type your response."; break;;
    esac
done

# Cleanup
unset TOKEN
