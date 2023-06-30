#!/bin/bash



# -------
# RUN IT
# -------
# cd /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts
# ./clone_repo.sh




# ---------------------------------------------
# Functions
# ---------------------------------------------

configure_settings_file_personalREPO(){

    # Inputs:
    # $1 = username
    # $2 = NOMDEREPO
    # $3 = useremail
    # $4 = folder_path_outside_git_dir
    
    if [[ $connection_method = "HTTPS" ]]; then
    	# HTTPS
    	export URL=$(echo "https://github.com/$1/$2.git")   # *** worked for git clone, did not work for git push ***
    else
    	# SSH
    	export URL=$(echo "git@github.com:$1/$2.git")   # *** worked for git push ***
    fi 
    
    git config --global user.name $1
    git config --global user.email $3
    git config --global remote.origin.url $URL    # changes remote.origin.url in /home/oem2/.gitconfig
    
    # To change remote.origin.url in .git/config
    # gedit .git/config
    # change manually
    
    # -------------------
    
    # Define a safe directory on the PC
    git config --global --add safe.directory $4
    
    # -------------------
    
    # View configuration file
    # git config --list --show-origin
    
    # -------------------
    
}


# ---------------------------------------------


configure_settings_file_NONpersonalREPO(){

    # Inputs:
    # $1 = username
    # $2 = useremail
    # $3 = HTTPS_URL
    # $4 = git_dir_folder_path
    
    git config --global user.name $1
    git config --global user.email $2
    git config --global remote.origin.url $3    # changes remote.origin.url in /home/oem2/.gitconfig
    
    # To change remote.origin.url in .git/config
    # gedit .git/config
    # change manually
    
    # -------------------
    
    # Define a safe directory on the PC
    git config --global --add safe.directory $4
    
    # -------------------
    
    # View configuration file
    # git config --list --show-origin
    
    # -------------------
    
}


# ---------------------------------------------








# ---------------------------------------------


# Clone a personal repo directory
export val=$(echo "X1")

if [[ $val == "X0" ]]
then
    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------
    # Personal user account
    export username=$(echo "j622amilah")
    export useremail=$(echo "j622amilah@gmail.com")

    # OR

    # Organization account
    # export username=$(echo "DevopsPractice7")
    # export useremail=$(echo "j622amilah@gmail.com")

    export connection_method=$(echo "SSH")  # SSH or HTTPS

    # ------------------- 

    # Idea steps : 
    # 0. make a temporary folder named git2 somewhere on the PC (folder_path), 
    # 1. download files from Github to git2 (if the repository files are not already on the machine, clone the repository to this temporary folder), 
    # 2. make changes on the PC,
    # 3. run this script to save changes to Github

    # Define the names to execute the steps below :
    # Folder path where one chooses to make changes to a git repository  
    # export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV")
    export folder_path=$(echo "/home/oem2/Documents/ONLINE_CLASSES/Spécialisation_Google_Data_Analytics/3_Google_Data_Analytics_Capstone_Complete_a_Case_Study")

    # Name of folder where the repository is located
    export folder_name=$(echo "git")
    export folder_num=$(echo "2")

    # Name of the repository
    # export NOMDEREPO=$(echo "mod_docx")
    export NOMDEREPO=$(echo "automatic_GCP_ingestion")

    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------

    export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name$folder_num")
    export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$NOMDEREPO")

    # Clone a directory that does not belong to you
    configure_settings_file_personalREPO $username $NOMDEREPO $useremail $git_dir_folder_path
    
    # Perform git clone
    cd $folder_path_outside_git_dir
    git clone $URL

fi


# ---------------------------------------------


# Clone a non-personal repo directory
export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------
    # Personal user account
    export username=$(echo "j622amilah")
    export useremail=$(echo "j622amilah@gmail.com")

    # OR

    # Organization account
    # export username=$(echo "DevopsPractice7")
    # export useremail=$(echo "j622amilah@gmail.com")

    export HTTPS_URL=$(echo "https://github.com/GoogleCloudPlatform/training-data-analyst")  # SSH or HTTPS
    
    # export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV")
    export folder_path=$(echo "/home/oem2/Documents/ONLINE_CLASSES/Google_cloud_service_website/Machine_Learning_Engineer_Learning_Path/3_How_Google_Does_Machine_Learning")

    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------


    # Clone a directory that does not belong to you
    configure_settings_file_NONpersonalREPO $username $useremail $HTTPS_URL $folder_path
    
    # Perform git clone
    cd $folder_path
    git clone $HTTPS_URL

fi


# ---------------------------------------------


