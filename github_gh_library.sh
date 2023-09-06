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
configure_settings_file(){

    # Inputs:
    # $1 = username
    # $2 = useremail
    # $3 = URL
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
    
    # Should be in git directory when pushing files to the main branch
    # cd $1
    git push origin $2
    # ------------------- 

}


# ---------------------------------------------






# ---------------------------------------------
# Functions to CALL with INPUTS
# ---------------------------------------------

# Example:
# clone_a_private_repo_directory /home/oem2/Documents Azure_cogserv_email_extraction
# clone_a_private_repo_directory /home/oem2/Documents ML_DL_modeling

clone_a_private_repo_directory(){

    # Inputs:
    # $1 = folder_path	# Directory where to put the files: export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING")
    # $2 = NOMDEREPO	# Name of the repository: export NOMDEREPO=$(echo "Notes")
    

    # Clone a private repo directory - you need to sign-in with credentials if the repo is private
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
    
    # ---------------------------------------------
    
    export connection_method=$(echo "SSH")  # SSH or HTTPS
    
    # ---------------------------------------------
    
    if [[ $connection_method == "HTTPS" ]]; then
    	# HTTPS
    	export URL=$(echo "https://github.com/$username/$2.git")
    else
    	# SSH
    	export URL=$(echo "git@github.com:$username/$2.git")
    fi 
    
    echo $URL
    
    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------
    
    # Idea steps : 
    # 0. make a temporary folder named git2 somewhere on the PC (folder_path), 
    # 1. download files from Github to git2 (if the repository files are not already on the machine, clone the repository to this temporary folder), 
    # 2. make changes on the PC,
    # 3. run this script to save changes to Github
    
    export folder_name=$(echo "git2")  # Folder name to put the repo files in
    
    cd $1
    
    if [[ ! -f $1/$folder_name ]];then 
    	mkdir $folder_name
    fi

    export folder_path_outside_git_dir=$(echo "$1/$folder_name")
    export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$2")
    
    # Clone a directory that does not belong to you
    configure_settings_file $username $useremail $URL $git_dir_folder_path
    
    # Perform git clone
    cd $folder_path_outside_git_dir
    
    git clone --recurse-submodules $URL

}


# ---------------------------------------------


clone_a_public_repo_directory(){

    # Clone a public repo directory
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
    
    # ---------------------------------------------

    # export HTTPS_URL=$(echo "https://github.com/GoogleCloudPlatform/training-data-analyst")  # SSH or HTTPS
    export HTTPS_URL=$(echo "https://github.com/Azure/login")
    
    # ---------------------------------------------
    
    # Directory where to put the files
    export folder_path=$(echo "/home/oem2/Documents/Github_analysis_PROJECTS/Azure_ML_Studio")
    # ---------------------------------------------
    # ***** CHANGE ONLY *****
    # ---------------------------------------------
    
    # Clone a directory that does not belong to you
    configure_settings_file $username $useremail $HTTPS_URL $folder_path
    
    # Perform git clone
    cd $folder_path
    git clone $HTTPS_URL

}


# ---------------------------------------------


# export NOMDEREPO=$(echo "mod_docx")
# export NOMDEREPO=$(echo " Azure_cogserv_email_extraction")
# export NOMDEREPO=$(echo "Git_scripts")
# export NOMDEREPO=$(echo "Case_Studies")
# export NOMDEREPO=$(echo "Case_Study_Book")
# export NOMDEREPO=$(echo "Notes")
# export NOMDEREPO=$(echo "ML_DL_modeling")

# Folder path where one chooses to put the folder "git2"
# export folder_path=$(echo "/home/oem2/Documents")

# Example:
# [0] clone the repo to folder_path : it will automatically create git2 and then the repo folder inside
# clone_a_private_repo_directory $folder_path $NOMDEREPO
#
# [1] make changes in the repo folder in git2
#
# [2] run the function below to pull the repo from GitHub, move your updated files to the pulled folder, then push all changes back to GitHub
# push_pull_changes_from_PC_to_a_repo_branch $folder_path $NOMDEREPO


push_pull_changes_from_PC_to_a_repo_branch(){

    # Inputs:
    # $1 = folder_path	# Directory where to put the files: export folder_path=$(echo "/home/oem2/Documents/PROGRAMMING")
    # $2 = NOMDEREPO	# Name of the repository: export NOMDEREPO=$(echo "Notes")

	export cur_path=$(pwd)
	echo "cur_path:"
	echo $cur_path
	
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
	
	# ---------------------------------------------
		
	# Name of folder where the repository is located
	export folder_name=$(echo "git2")

	# Name of the branch to use to make changes to the repository
	export branch_name=$(echo "main")   # the name can be anything but 'master'
	# ---------------------------------------------
	# ***** CHANGE ONLY *****
	# ---------------------------------------------


	# ---------------------------------------------
	# Define existing PATHS
	# ---------------------------------------------
	# Step 1: Set repo and path variables
	export folder_path_outside_git_dir=$(echo "$1/$folder_name")
	export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$2")
	# ---------------------------------------------


	# ---------------------------------------------
	# Configure file Settings
	# ---------------------------------------------
	if [[ $connection_method == "HTTPS" ]]; then
	     # HTTPS
	     export URL=$(echo "https://github.com/$username/$2.git")
	else
	     # SSH
	     export URL=$(echo "git@github.com:$username/$2.git")
	fi
	
	configure_settings_file $username $useremail $URL $git_dir_folder_path


	# ---------------------------------------------
	# Create temporary folder
	# ---------------------------------------------
	# Problem with git (Git copies over the changes that you made when you try to pull-push to the GitHub repo, and if you do push alone without pull Git gives an error.)

	# You have a folder on the PC that is identical to the folder that is on the repo
	# /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git2/mod_docx

	# But, you modify the files on the PC. 

	# Then you have to do a git pull all the time for the libraries on the repo and PC to sync up, so you have to create a new folder to do the git pull  

	# [Step 0] Create a new folder to do git pull from the old repo files
	# New method
	export folder_TEMP=$(echo "_pulled_folder")
	
	export folder_path_outside_git_dir_TEMP=$(echo "$1/$folder_name$folder_TEMP")
	export git_dir_folder_path_TEMP=$(echo "$folder_path_outside_git_dir_TEMP/$2")
	# ---------------------------------------------


	# ---------------------------------------------
	# PULL from repo : one must pull to a new folder, or else it will copy over your files that you changed
	# ---------------------------------------------
	echo 'Pulling repo from GitHub'
	pull_from_a_branch_repo $folder_path_outside_git_dir_TEMP $git_dir_folder_path_TEMP $branch_name
	# ---------------------------------------------


	# ---------------------------------------------
	# Need to copy the changed files in git_dir_folder_path to the "Git synced folder" at git_dir_folder_path_TEMP
	# ---------------------------------------------
	# Pull files from GitHub, and copy my new changed files into the folder
	# Leave the .git in the git2_pulled_folder because it gives the state of the files on the GitHub repo, we want to update this with the GitHub commands
	
	# Delete all the file except .git
	mv .git $folder_path_outside_git_dir_TEMP

	cd $folder_path_outside_git_dir_TEMP

	rm -rf $git_dir_folder_path_TEMP

	mkdir $git_dir_folder_path_TEMP

	mv .git $git_dir_folder_path_TEMP

	# Remove .git from old folder
	cd $git_dir_folder_path
	rm -rf .git
	
	# Copy the new files from my PC to the temp folder
	cp -a $git_dir_folder_path/. $git_dir_folder_path_TEMP
	cd $git_dir_folder_path_TEMP
	# ---------------------------------------------


	# ---------------------------------------------
	# PUSH to repo on the main branch
	# ---------------------------------------------
	echo 'Pushing changes back to repo'
	push_to_a_branch_repo $git_dir_folder_path_TEMP $branch_name
	# ---------------------------------------------
	

	# ---------------------------------------------
	# Delete old folder : not doing mv because I want to be sure that all the files in the subfolders are deleted
	# ---------------------------------------------
	# Automatically delete the OLD folder
	# rm -rf $folder_path_outside_git_dir
	# 
	# OR
	#
	# Rename the OLD folder as something to delete (automatic deleting can be dangerous)
	mv $folder_path_outside_git_dir $1/git2_OLD_to_delete
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


move_a_git_repo_to_another_repo(){
	
	# Be sure to already have created the main repo; put the main repo name here
	export main_repo_name=$(echo "ML_DL_modeling")
	
	export folder_path=$(echo "/home/oem2/Documents/git2")
	
	# Make an array of repos names to consolidate to another main repo
	declare -a repos2move=($main_repo_name 'Azure_cogserv_email_extraction' 'Databricks_usage' 'Q_learning_project' 'Motor_classification' 'Son_des_oiseaux2' 'LSTM' 'Classify_sentences' 'Chatbot' 'Automate_files' 'Hackerrank_test' 'Histogram_object_detection' 'EEG_DAD' 'n4sid_prediction' 'Heart_jewelry' 'DataFrame-parser' 'unsupervised_label_assignment' 'changepoint_analysis' 'Interpolation_methods' 'hand_gesture_CNN' 'Obtaining_the_frequency_of_a_signal' 'Cousera_cat_DL_classification' 'chess_moves' 'Resume_compare_python' 'Heart_classification');
		
	echo 'repos2move'
	echo $repos2move	
	
	# Get the length of the array
	export N=$(echo ${#repos2move[@]})
	
	echo 'N'
	echo $N
	
	export step0=$(echo "X0")
	export step1=$(echo "X0")
	
	
	for r in $( seq 0 $N )
	do
		echo $r
		echo ${repos2move[$r]}
			
		# ---------------------------------------------
		
		if [[ $step0 == "X0" ]]
		then
			# Clone the repos on the main repo
			# Be sure to use git clone --recurse-submodules to remove the .git from the subrepo folder
			# A .git file in a subdirectory will lock the folder, put an arrow on it 
			clone_a_private_repo_directory $folder_path ${repos2move[$r]}
			
			if [[ ${repos2move[$r]} != $main_repo_name ]]
			then 
				mv ${repos2move[$r]} $main_repo_name
			fi
		fi
		
		# ---------------------------------------------
		
		if [[ $step1 == "X0" ]]
		then
			# Verify that the .git folder in each subrepo is deleted
			export repo_path=$(echo $folder_path/$main_repo_name/${repos2move[$r]})
			echo $repo_path
			
			cd $repo_path
			
			rm -rf .git
		fi
		
		# ---------------------------------------------
	done
	
	# Step 2
	# Update the repo main branch of the main_repo_name with the modifications
	push_pull_changes_from_PC_to_a_repo_branch $folder_path $main_repo_name
	
	# Step 3: Delete all the old subrepos from GitHub

}


# ---------------------------------------------

merge_a_branch_with_the_master_branch(){

	# The main branch is the branch name that I am working on, but if I work in a team the production/team branch is the master branch. If I need to share my work with my team members, I need to push my changes to the master branch so the work is put into production OR the GitHub actions workflow can update with the changes that I made.
	
	# Name of the branch to use to make changes to the repository
	export branch_name=$(echo "main")

	# ---------------------------------------------
	# PUSH changes made on the main branch to the master branch 
	# ---------------------------------------------
	# Change to the branch named $branch_name
	git checkout $branch_name

	# Rename the branch named $branch_name to the branch master
	git branch -m master

	# pull down files from master branch
	git pull --allow-unrelated-histories

	# There will be conflict file errrors:
	# Way 0: Rebase, but this is not automatic, you have to manually change conflicting files
	# git config pull.rebase true   # it adds all the changes to one file (.github/workflows/main.yml) on the PC
	# Open the file (.github/workflows/main.yml) and make changes you want
	# git add .github/workflows/main.yml
	# git rebase --continue

	# git config pull.rebase false  # fusion (stratégie par défaut)
	# OR
	# OR
	# git config pull.ff only

	# Set origin/master to track your local branch master
	# git push -u origin master
	# ---------------------------------------------
		
	
}


# ---------------------------------------------





















# ---------------------------------------------
# gh : Github API command line tool
# https://cli.github.com/manual
# sudo zypper install gh
# ---------------------------------------------


login_to_gh(){

    # Personal Access Token (PAT)
    export PAT=$(echo "")

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
    # export NOMDEREPO=$(echo "Case_Studies")
    export NOMDEREPO=$(echo "Case_Study_Book")

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


delete_git_repo_gh(){

	# List of repos to delete
	declare -a repos2move=('Azure_cogserv_email_extraction' 'Databricks_usage' 'Q_learning_project' 'Motor_classification' 'Son_des_oiseaux2' 'LSTM' 'Classify_sentences' 'Chatbot' 'Automate_files' 'Hackerrank_test' 'Histogram_object_detection' 'EEG_DAD' 'n4sid_prediction' 'Heart_jewelry' 'DataFrame-parser' 'unsupervised_label_assignment' 'changepoint_analysis' 'Interpolation_methods' 'hand_gesture_CNN' 'Obtaining_the_frequency_of_a_signal' 'chess_moves' 'Resume_compare_python' 'Heart_classification');
		
	echo 'repos2move'
	echo $repos2move	
	
	# Get the length of the array
	export N=$(echo ${#repos2move[@]})
	
	echo 'N'
	echo $N
	
	for r in $( seq 0 $N )
	do
		echo $r
		
		gh repo delete ${repos2move[$r]}
		
	done

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








