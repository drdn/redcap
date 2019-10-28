## Description:
Makes a call to a redcap instance to programmatically perfrom a lock/unlock/status action for provided record ids of records.
## Dependencies:
Requires the external module 'locking_api'. External module documentation located at: [](https://github.com/lsgs/redcap-locking-api/)

##Arguments:
Requires config.txt and ids.txt located in the same directory as the script.

Config.txt should have a valid project API Token on line 1 and a valid REDCap endpoint on line 2.

Ids.txt should be a list of valid record ids for which to perfrom the lock/unlock/status action on separate lines.