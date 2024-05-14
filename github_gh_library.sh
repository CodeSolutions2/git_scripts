#!/bin/bash

# -------
# RUN IT
# -------
# [0] on Bash
# cd /to/path/you/want/gitN/to/be/created
# git clone https://github.com/CodeSolutions2/temp_repo
# source /to/path/you/want/gitN/to/be/created/temp_repo/github_gh_library_short.sh
# RUN_IT_BEFORE_CHANGES
# [7] Manually make the changes in the repo folder in git2 - *** CHANGE the files that need to be changed ***
# RUN_IT_AFTER_CHANGES

# ---------------------------------------------

# https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories

# ---------------------------------------------
# Github command line tools
# ---------------------------------------------

# ---------------------------------------------
# USER_INPUTS
# ---------------------------------------------
# [0] Define RepoName
export RepoName=$(echo "RepoName")

# [1] Select the [folder path] where one chooses to put the folder "git2" (git2 is a main folder that is created to contain the downloaded repo)
export folder_path=$(echo "/home/username/Documents")

# [2] RepoOwnerName
export username=$(echo "RepoOwnerName")

# [3] User email
export useremail=$(echo "RepoOwnerName@gmail.com")

# [4] Connection method
# export connection_method=$(echo "SSH")
export connection_method=$(echo "HTTPS")

# [5] folder_name (it is the name of the folder containing the repository, called "git2")
export folder_name=$(echo "git2")  # Folder name to put the repo files in

# [6] Branch name to use to make changes to the repository
export branch_name=$(echo "main")   # the name can be anything but 'master'
 
# ---------------------------------------------

RUN_IT_BEFORE_CHANGES(){

  # [6] Clone the repo to folder_path : it will automatically create git2 and then the repo folder inside
  create_main_gitN_folder_AND_clone_repository

  # [7] Manually make the changes in the repo folder in git2 - *** CHANGE the files that need to be changed ***

}

RUN_IT_AFTER_CHANGES(){

  # [6] Update GitHub with your changes: pull the repo from GitHub, move your updated files to the pulled folder, then push all changes back to GitHub
  push_pull_changes_from_PC_to_a_repo_branch

}

# ---------------------------------------------
# Dependant functions that DO NOT CHANGE
# ---------------------------------------------
configure_settings_file(){

    # Inputs:
    # $1 = URL
    # $2 = git_dir_folder_path

    # -------------------

    # Reset existing configurations: Remove the git.recentrepo
    git config --global --unset-all gui.recentrepo
    
    # -------------------
    
    echo "Set user name: $username"
    git config --global user.name $username

    echo "Set user email: $useremail"
    git config --global user.email $useremail

    # Changes remote.origin.url in /home/oem2/.gitconfig
    echo "Set repository url: $1"
    git config --global remote.origin.url $1
    
    # -------------------
    
    # To change remote.origin.url in .git/config
    # gedit .git/config
    # change manually
    
    # -------------------
    
    # Define a safe directory on the PC
    echo "Set the safe directory to: $2"
    git config --global --add safe.directory $2
    
    # -------------------

    # Specify how to handle some file changes that may trigger errors.
    # If one removes data from a file it may give an error, saying 
    # "You have divergent branches and need to specify how to reconcile them". 
    # Thus, one needs to tell Git to accept the changes either by: 
    # [0] combining the current and previous file contents into the new file (merge), 
    # [1] accepting the file that was changed last by chronological order (rebase), 
    # [2] selecting a combination of the latest changes on the main branch and the 
    # latest changes on your branch (fast-forward).

    # Rebase is selected as a strategy to handle conflict error
    # git config --global pull.rebase false # merge (the default strategy)
    git config --global pull.rebase true  # rebase
    # git config --global pull.ff only 

    # -------------------
    
    echo "View final Git configuration:"
    git config --list --show-origin
    
    # -------------------
    
}

# ---------------------------------------------

pull_from_a_branch_repo(){

    # Inputs:
    # $1 = folder_path_outside_git_dir (example: /../gitN)
    # $2 = git_dir_folder_path (example: /../gitN/RepoName)
    
    # ------------------- 
    # PULL from an assigned initial branch : these steps are performed once before modifying files
    # ------------------- 
    # Should be outside the git directory when initializing a local directory
    mkdir $1
    cd $1
    
    mkdir $2
    
    # --------------------- This is correct now... ---------------------
    
    # Should be in the git directory when pulling files
    cd $2
    
    echo "pull_from_a_branch_repo: Initialize the local directory"
    git init

    # ---------------------
    # Specify additional settings:
    # [A] Add a remote repository (Really this is OPTIONAL because the global remote repository is set in configure_settings_file)
    # [B] Ensure one is on the CORRECT branch_name
    # ---------------------
    # [A] Add a remote repository: tell Git that this folder is connected to the repository on GitHub
    echo "Add a remote repository"
    git remote add origin $URL
   
    echo "View the remote repositories (-v=verbose)"
    git remote -v
    # origin https://github.com/CodeSolutions2/github_actions_practice.git (fetch)
    # origin https://github.com/CodeSolutions2/github_actions_practice.git (push)
    # origin https://github.com/CodeSolutions2/github_actions_practice.git (push)

    # --------------------- 

    # UNDERSTANDING: Eventhough the main branch exists on GitHub, a branch named main does not exist for [git CLI/the local PC]. After one does a Pull request from the repository, [git CLI/the local PC] creates a branch named main for the PC to associate with the URL address.
    
    # --------------------- 
    
    echo "pull_from_a_branch_repo: Pull Repository from github first, while synchronizing the branches"
    git pull origin $branch_name --allow-unrelated-histories
    
    # remote: Enumerating objects: 139, done.
    # remote: Counting objects: 100% (7/7), done.
    # remote: Compressing objects: 100% (3/3), done.
    # remote: Total 139 (delta 5), reused 4 (delta 4), pack-reused 132
    # Receiving objects: 100% (139/139), 55.16 KiB | 1.90 MiB/s, done.
    # Resolving deltas: 100% (57/57), done.
    # From https://github.com/CodeSolutions2/github_actions_practice
    # * branch            main       -> FETCH_HEAD
    # * [new branch]      main       -> origin/main

    # --------------------- 
    
    # A branch named variable called main is created for the [git CLI/the local PC] after the pull, eventhough it already exists on the GitHub repository.

    # --------------------- 
    
    # The difference between clone and pull, is that clone just gives the files. 
    # But, pull gives the files and DEFINES the branch information so that one can push back the new data using the branch information.
    
    # --------------------- 

    # Now that the [git CLI/the local PC] has updated branch information, we can view the branches.
    
    # [B] Ensure that the CORRECT branch_name is selected
    echo "View the branches AFTER the PULL"
    git branch
    
    # * master

    echo "Switch to the branch named $branch_name: AFTER the PULL"
    git checkout $branch_name
    
    # Branch 'main' set up to track remote branch 'main' from 'origin'.
    # Switched to a new branch 'main'
    # Pushing changes back to repo
    # [main f8dbcab] Updating repository
    # 1 file changed, 1 insertion(+)
    # create mode 100644 .github/workflows/main.yml

    # --------------------- 

}

# ---------------------------------------------

push_to_a_branch_repo(){

    # Inputs:
    # $1 = git_dir_folder_path (EXAMPLE: /../gitN/RepoName)
    
    
    # ------------------- 
    # PUSH from an assigned initial branch : these steps repeat 
    # -------------------
    # Should be in git directory when adding files to be updated
    cd $1
    git add .     # (if you want to add everything in the local repository that was specified in the config file)
    # OR 
    # git filename
    
    # Should be in git directory (git_dir_folder_path) when commiting files
    git commit -m "Updating repository"

    # --------------------- 
    
    # Should be in git directory (git_dir_folder_path) when pushing files to the main branch
    echo "push_to_a_branch_repo: git push origin $branch_name"
    git push origin $branch_name
    
    # Username for 'https://github.com': ^C

    # ------------------- 

}

# ---------------------------------------------

create_main_gitN_folder_AND_clone_repository(){

    # Idea steps : 
    # 0. make a temporary folder named git2 somewhere on the PC (folder_path), 
    # 1. download files from Github to git2 (if the repository files are not already on the machine, clone the repository to this temporary folder), 
    # 2. make changes on the PC,
    # 3. run this script to save changes to Github

    # ---------------------------------------------

    if [[ $connection_method == "HTTPS" ]]; then
     # HTTPS: https://github.com/OWNER/REPOSITORY.git
     export URL=$(echo "https://github.com/$username/$RepoName.git")
    else
     # SSH
     export URL=$(echo "git@github.com:$username/$RepoName.git")
    fi 
    
    echo $URL

    # ---------------------------------------------
    
    cd $folder_path
    
    if [[ ! -f $folder_path/$folder_name ]];then 
     mkdir $folder_name
    fi

    export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name")
    export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$RepoName")
    
    # Clone a directory that does not belong to you
    configure_settings_file $URL $git_dir_folder_path
    
    # Perform git clone
    cd $folder_path_outside_git_dir
    
    git clone --recurse-submodules $URL

}

# ---------------------------------------------

push_pull_changes_from_PC_to_a_repo_branch(){

 # Idea steps : 
 # 0. make a temporary folder named git2 somewhere on the PC (folder_path), 
 # 1. download files from Github to git2 (if the repository files are not already on the machine, clone the repository to this temporary folder), 
 # 2. make changes on the PC,
 # 3. run this script to save changes to Github

 # ---------------------------------------------

 export cur_path=$(pwd)
 echo "cur_path: $cur_path"

 # ---------------------------------------------
 # Define existing PATHS
 # ---------------------------------------------
 # Step 1: Set repo and path variables
 export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name")
 export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$RepoName")
 # ---------------------------------------------

 # ---------------------------------------------
 # Configure file Settings
 # ---------------------------------------------
 if [[ $connection_method == "HTTPS" ]]; then
      # HTTPS
      export URL=$(echo "https://github.com/$username/$RepoName.git")
 else
      # SSH
      export URL=$(echo "git@github.com:$username/$RepoName.git")
 fi
 
 configure_settings_file $URL $git_dir_folder_path

 # ---------------------------------------------
 # Create temporary folder
 # ---------------------------------------------
 # Problem with git (Git copies over the changes that you made when you try to pull-push to the GitHub repo, and if you do push alone without pull Git gives an error.)

 # You have a folder on the PC that is identical to the folder that is on the repo
 # path location in the folder /../gitN/RepoName

 # But, you modify the files on the PC. 

 # Then you have to do a git pull all the time for the libraries on the repo and PC to sync up, so you have to create a new folder to do the git pull  

 # [Step 0] Create a new folder to do git pull from the old repo files
 # New method
 export folder_TEMP=$(echo "_pulled_folder")
 
 export folder_path_outside_git_dir_TEMP=$(echo "$folder_path/$folder_name$folder_TEMP")
 export git_dir_folder_path_TEMP=$(echo "$folder_path_outside_git_dir_TEMP/$RepoName")
 # ---------------------------------------------

 # ---------------------------------------------
 # PULL from repo : one must pull to a new folder, or else it will copy over your files that you changed
 # ---------------------------------------------
 echo "Starting pull_from_a_branch_repo:"
 pull_from_a_branch_repo $folder_path_outside_git_dir_TEMP $git_dir_folder_path_TEMP
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
 push_to_a_branch_repo $git_dir_folder_path_TEMP
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
 mv $folder_path_outside_git_dir $folder_path/git2_OLD_to_delete
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
