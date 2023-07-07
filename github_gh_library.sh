#!/bin/bash


# -------
# RUN IT
# -------
# cd /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts/git2/Git_scripts
# source ./github_gh_library.sh
# call the functions


# ---------------------------------------------
# Github command line tools
# ---------------------------------------------


# ---------------------------------------------
# Dependant functions that DO NOT CHANGE
# ---------------------------------------------
configure_settings_file_personalREPO(){

    # Inputs:
    # $1 = username
    # $2 = NOMDEREPO
    # $3 = useremail
    # $4 = git_dir_folder_path
    # $5 = connection_method
    
    if [[ $5 = "HTTPS" ]]; then
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






# ---------------------------------------------
# Functions to CALL with INPUTS
# ---------------------------------------------
clone_a_personal_repo_directory(){


    # Clone a personal repo directory
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
    export folder_name=$(echo "git2")

    # Name of the repository
    # export NOMDEREPO=$(echo "mod_docx")
    export NOMDEREPO=$(echo "automatic_GCP_ingestion")
    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------
    
    

    export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name")
    export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$NOMDEREPO")

    # Clone a directory that does not belong to you
    configure_settings_file_personalREPO $username $NOMDEREPO $useremail $git_dir_folder_path $connection_method
    
    # Perform git clone
    cd $folder_path_outside_git_dir
    git clone $URL

}


# ---------------------------------------------


clone_a_personal_repo_directory(){


    # Clone a non-personal repo directory
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

}


# ---------------------------------------------

push_pull_changes_from_PC_to_repo(){

	export cur_path=$(pwd)
	
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
	
	# Name of the repository
	# export NOMDEREPO=$(echo "mod_docx")
	# export NOMDEREPO=$(echo "GCP_ingestion_analysis_tools")
	export NOMDEREPO=$(echo "Git_scripts")
	# export NOMDEREPO=$(echo "Case_Studies")
	
	# Define the names to execute the steps below :
	# Folder path where one chooses to make changes to a git repository  
	# export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV")
	# export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Case_Studies")
	export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts")

		
	# Name of folder where the repository is located
	export folder_name=$(echo "git2")

	# Name of the branch to use to make changes to the repository
	export branch_name=$(echo "main")
	# ---------------------------------------------
	# ***** CHANGE ONLY *****
	# ---------------------------------------------


	# ---------------------------------------------
	# Define existing PATHS
	# ---------------------------------------------
	# Step 1: Set repo and path variables
	export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name")
	export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$NOMDEREPO")
	# ---------------------------------------------


	# ---------------------------------------------
	# Configure file Settings
	# ---------------------------------------------
	configure_settings_file_personalREPO $username $NOMDEREPO $useremail $git_dir_folder_path $connection_method


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
	export folder_TEMP=$(echo "_delete") # put git pull files in a git_delete folder
	export folder_path_outside_git_dir_TEMP=$(echo "$folder_path/$folder_name$folder_TEMP")
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
	
	# Return to the orginal path, instead of staying in the push path
	cd $cur_path

}


















# ---------------------------------------------
# gh : Github API command line tool
# ---------------------------------------------


login_to_gh(){

    # Personal Access Token (PAT)
    export PAT=$(echo "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")

    # export finegrainedPAT=$(echo "https://docs.github.com/fr/rest/overview/permissions-required-for-fine-grained-personal-access-tokens?apiVersion=2022-11-28 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")


    # The GITHUB_TOKEN secret is a GitHub App installation access token. 
    # https://cli.github.com/manual/gh_auth_login
    # sudo echo "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" >> GH_TOKEN.txt
    # gh auth login --with-token < GH_TOKEN.txt

    # ---------------------------------------------

    gh auth login --with-token $PAT | gh auth login --scopes "read:org"

    # -----------------------OU----------------------

    # gh auth login --with-token $PAT
    # gh auth login --scopes "read:org"
    # OU
    # gh auth login --scopes "repo"

}


# ---------------------------------------------



create_git_repo_gh(){


    # Creates a new remote repository and clones it locally
    
    # export NOMDEREPO=$(echo "mod_docx")
    # export NOMDEREPO=$(echo "Git_scripts")
    export NOMDEREPO=$(echo "Case_Studies")

    # Go to the folder path where one chooses to make changes to a git repository : the folder path where the files are located
    export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/$NOMDEREPO")
    cd $folder_path
    
    
    # Create a new remote repository and clone it locally: this command creates a folder called $NOMDEREPO in the same directory and make the git repo
    gh repo create $NOMDEREPO --public --clone

    # Create a README in the same directory
    sudo echo $NOMDEREPO >> README.md
    # OU
    # sudo touch README.md
    # OU
    # sudo echo $NOM_DE_REPO | cat >> README.md
	
    # Move all the files into the $NOMDEREPO folder

}


# ---------------------------------------------


list_git_repo_gh(){

    # List the git repositories
    gh repo list

}


# ---------------------------------------------


create_a_release_gh(){

    # Create a new release/tag for published code

    # Organization account
    export username=$(echo "DevopsPractice7")

    export NOMDEREPO=$(echo "mod_docx")

    # Create the first release
    gh release create --repo $username/$NOMDEREPO --title "Version 10" --notes "Correction of errors: incorrect indentation line 242." 0.1.0
    
}


# ---------------------------------------------
