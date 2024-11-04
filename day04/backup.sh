#!/bin/bash

<< readme

        This is a script for backup with 5 day rotation

        USAGE:
        ./backup.sh <path to your source> <[path to backup folder>

readme

# Function to displa usage instructions
function display_usage {

        echo "USAGE ./backup.sh <path to your source> <[path to backup folder>"
}

# Check if no arguments are passed; if so, display usage
if [ $# -eq 0 ]; then
        display_usage
fi

# Assigning the first argument to backup_dir, which is the backup storage location
source_dir=$1

# Generating a timestamp for the backup file name
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

# Assinging the second argument to backup_dir, which is the backup storage location
backup_dir=$2


# Function to create a backup
function create_backup {


        # Using zip to compress the source directory into a .zip file in the back directory
        # Redirecting output to /dev/null to suppress warnins messages
        zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null

        # Checking if the zip command was successful ( exit code 0 indicated success )


        if [ $? -eq 0 ]; then  #$? = if command just above this line generates an error than it will be $? otherwise its value will be 0
        echo "Backup generated successfully for ${timestamp}"
        fi

}

# Function to perform backup rotation, keeping only the last 5 backups
function perform_rotation {

        # ($()) outer () indicated array of backup
        # 2>/dev/nul discard all the standard errors


        backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
        #echo "${backups[@]}"

        # to check the length of backups[@] array add # before that
        if [ "${#backups[@]}" -gt 5  ]; then
                echo "Performing rotation for 5 days"


        # Array slicing to keep the latest 5 backups and mark older ones for deletion
        # backups[@]:5 #this command will print the array form 5th location
        backups_to_remove=("${backups[@]:5}")
                #echo "${backups_to_remove[@]}"


                # Loop through the backups to remove and delete each
                for backup in "${backups_to_remove[@]}";
                do
                        rm -f ${backup}
                done

        fi

}

# Execute the backup creation and rotation functions
create_backup
perform_rotation
