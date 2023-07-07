#!/bin/bash

# cd /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts

# ./PUSH_PULL_changes_from_PC_to_repo.sh



# ---------------------------------------------
# Functions
# ---------------------------------------------

pull_from_a_branch_repo(){

    # Inputs:
    # $1 = folder_path_outside_git_dir # /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git3
    # $2 = git_dir_folder_path # /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git3/mod_docx
    # $3 = branch_name
    
    # ------------------- 
    # Push from an assigned initial branch : these steps are performed once before modifying files
    # ------------------- 
    # Should be outside the git directory when initializing a local directory
    mkdir $1
    cd $1
    
    mkdir $2
    
    # --------------------- This is correct now... ---------------------
    # Should be in the git directory when pulling files
    cd $2
    
    # Initialize the local directory and set the initial branch name to main
    git init -b $3
    # --------------------- 
    
    # Pull Repository from github first, while synchronizing the branches
    git pull origin $3 --allow-unrelated-histories

}

# ---------------------------------------------

push_to_a_branch_repo(){

    # Inputs:
    # $1 = git_dir_folder_path
    # $2 = branch_name
    
    
    # ------------------- 
    # Push from an assigned initial branch : these steps repeat 
    # -------------------
    # Should be in git directory when adding files to be updated
    cd $1
    git add .     # (if you want to add everything in the local repository that was specified in the config file)
    # OR 
    # git filename
    
    # Should be in git directory when commiting files
    # cd $1
    git commit -m "comment"
    
    # Should be in git directory when pushing files
    # cd $1
    git push origin $2
    # ------------------- 

}

# ---------------------------------------------

configure_settings_file(){

    # Inputs:
    # $1 = git_dir_folder_path
    # username
    # useremail
    # connection_method
    
    if [[ $connection_method = "HTTPS" ]]; then
    	# HTTPS
    	export URL=$(echo "https://github.com/${username}/${NOMDEREPO}.git")   # *** worked for git clone, did not work for git push ***
    else
    	# SSH
    	export URL=$(echo "git@github.com:${username}/${NOMDEREPO}.git")   # *** worked for git push ***
    fi
    
    git config --global user.name $username
    git config --global user.email $useremail
    git config --global remote.origin.url $URL    # changes remote.origin.url in /home/oem2/.gitconfig
    
    # To change remote.origin.url in .git/config
    # gedit .git/config
    # change manually
    
    # -------------------
    
    # Define a safe directory on the PC
    git config --global --add safe.directory $1
    
    # -------------------
    
    # View configuration file
    # git config --list --show-origin
    
    # -------------------
    
}




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
export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Case_Studies")
# export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts")


# Name of folder where the repository is located
export folder_name=$(echo "git")
export folder_num=$(echo "2")

# Name of the repository
# export NOMDEREPO=$(echo "mod_docx")
# export NOMDEREPO=$(echo "GCP_ingestion_analysis_tools")
# export NOMDEREPO=$(echo "Git_scripts")
export NOMDEREPO=$(echo "Case_Studies")

# Name of the branch to use to make changes to the repository
export branch_name=$(echo "main")
# ---------------------------------------------
# ***** CHANGE ONLY *****
# ---------------------------------------------











# ---------------------------------------------
# Define existing PATHS
# ---------------------------------------------
# Step 1: Set repo and path variables
export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name$folder_num")
export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$NOMDEREPO")
# ---------------------------------------------




# ---------------------------------------------
# Configure file Settings
# ---------------------------------------------
configure_settings_file $git_dir_folder_path




# ---------------------------------------------
# Create temporary folder
# ---------------------------------------------
# Problem with git (Git copies over the changes that you made when you try to pull-push to the GitHub repo, and if you do push alone without pull Git gives an error.)

# You have a folder on the PC that is identical to the folder that is on the repo
# /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git2/mod_docx

# But, you modify the files on the PC. 

# Then you have to do a git pull all the time for the libraries on the repo and PC to sync up, so you have to create a new folder 
# to do the git pull  

# [Step 0] Create a new folder to do git pull from the old repo files
export folder_num_TEMP=$(echo $(($folder_num + 1)))
export folder_path_outside_git_dir_TEMP=$(echo "$folder_path/$folder_name$folder_num_TEMP")
export git_dir_folder_path_TEMP=$(echo "$folder_path_outside_git_dir_TEMP/$NOMDEREPO")

# ---------------------------------------------




# ---------------------------------------------
# PULL from repo
# ---------------------------------------------
pull_from_a_branch_repo $folder_path_outside_git_dir_TEMP $git_dir_folder_path_TEMP $branch_name

# ---------------------------------------------




# ---------------------------------------------
# Need to copy the changed files in git_dir_folder_path to the "Git synced folder" at git_dir_folder_path_TEMP
# ---------------------------------------------

# Delete all the file except .git
mv .git $folder_path_outside_git_dir_TEMP

cd $folder_path_outside_git_dir_TEMP

rm -rf $git_dir_folder_path_TEMP

mkdir $git_dir_folder_path_TEMP

mv .git $git_dir_folder_path_TEMP

# Remove .git from old folder
cd $git_dir_folder_path
rm -rf .git

cp -a $git_dir_folder_path/. $git_dir_folder_path_TEMP
cd $git_dir_folder_path_TEMP
# ---------------------------------------------


# ---------------------------------------------
# PUSH to repo
# ---------------------------------------------
push_to_a_branch_repo $git_dir_folder_path_TEMP $branch_name

# ---------------------------------------------



# ---------------------------------------------
# Delete old folder : not doing mv because I want to be sure that all the files in the subfolders are deleted
# ---------------------------------------------
rm -rf $folder_path_outside_git_dir

# ---------------------------------------------


# ---------------------------------------------
# Rename new folder as the old folder
# ---------------------------------------------
mv $folder_path_outside_git_dir_TEMP $folder_path_outside_git_dir

# ---------------------------------------------



