#!/bin/bash

# [0] Define Repository Name
export RepoName=$(echo "RepoName")

# [1] Select the [folder path] where one chooses to put the folder "git2" (git2 is a main folder that is created to contain the pulled repo)
export folder_path=$(echo "/home/username/Documents")

# [2] Define the Repository Owner Name
export RepoOwnerName=$(echo "RepoOwnerName")

# [3] Define the Repository Owner Email
# To view your non-reply email address go to https://github.com/settings/emails.
# RepoOwnerEmail="91731082+j622amilah@users.noreply.github.com";
# OR
# RepoOwnerEmail="j622amilah@gmail.com";
export RepoOwnerEmail=$(echo "RepoOwnerEmail@gmail.com")

# [4] Connection method: Define how one wants to connect to GitHub (SSH or HTTPS)
export connection_method=$(echo "SSH")
OR
export connection_method=$(echo "HTTPS")

# [5] folder_name (it is the name of the folder containing the repository, called "git2")
export folder_name=$(echo "git2")  # Folder name to put the repo files in

# [6] Branch name to use to make changes to the repository
export branch_name=$(echo "main")   # the name can be anything but 'master'

# [7] Set up the folder path
cd $folder_path
mkdir $folder_name

export folder_path_outside_git_dir=$(echo "$folder_path/$folder_name")
export git_dir_folder_path=$(echo "$folder_path_outside_git_dir/$RepoName")

# [8] Set the git configuration file: the configuration file is located in the home directory for linux: /home/username/.gitconfig.
git config --global user.name $RepoOwnerName
git config --global user.email $RepoOwnerEmail

# Reset the author information on your last commit. When you push (git push) the commit with the noreply e-mail address, future commits will have the [noreply OR normal] e-mail address.
git commit --amend --reset-author

# Specify the remote repository: if the URL is set in the configuration file one does not need to add a remote repository [git remote add origin $URL] after running [git init]
if [[ $connection_method == "HTTPS" ]]; then
   # HTTPS
   export URL=$(echo "https://github.com/$RepoOwnerName/$RepoName.git")
else
   # SSH
   export URL=$(echo "git@github.com:$RepoOwnerName/$RepoName.git")
fi 
git config --global remote.origin.url $URL
# OR
git remote set-url origin https://$GITHUB_TOKEN@github.com/$RepoOwnerName/$RepoName.git

# Specify the directory where the .git folder is as "Safe"/Accessable
git config --global --add safe.directory $git_dir_folder_path

# Specify how to handle some file changes that may trigger errors. 
#If one removes data from a file it may give an error, saying "You have divergent branches and need to specify how to reconcile them". Thus, one needs to tell Git to accept the changes either by: 
#- [0] combining the current and previous file contents into the new file (merge),
#- [1] accepting the file that was changed last by chronological order (rebase),
#- [2] selecting a combination of the latest changes on the main branch and the latest changes on your branch (fast-forward).

git config --global pull.rebase false # merge (the default strategy)
OR
git config --global pull.rebase true  # rebase
OR
git config --global pull.ff only 

# View the final Git configuration
git config --list --show-origin

# Pull from a branch
Go to /home/user_name/Documents/git2 path
cd $folder_path_outside_git_dir

# Create the .git folder inside the current path
git init

# Pull to the current path
git pull origin $branch_name

# After the pull, the branches on GitHub will be created for git command line [git CLI/the local PC].

# Now that the [git CLI/the local PC] has updated branch information, view the branches.

echo "View the branches AFTER the PULL"
git branch

git branch --set-upstream-to origin/main; 

echo "Switch to the branch named $branch_name: AFTER the PULL"
git checkout $branch_name

# If you can not change to the branch_name that exists on GitHub using [git checkout $branch_name], it means that settings on the [git CLI/the local PC] are not the same as on GitHub, try updating the [git CLI/the local PC] information using [git fetch -all].

# If this still does not work, create a branch on the [git CLI/the local PC] using [git branch $branch_name]. Then switch to the branch using [git checkout $branch_name].

# Make changes

# Push to a branch
One needs to be inside the Git repository folder path. Go to /home/user_name/Documents/git2/$RepoName
cd $git_dir_folder_path

# Add all the modified files since the pull to the staging area
git add .

# Add a comment to explain the file changes
git commit -m "Updating repository"

# Push to the branch name on GitHub
git push origin $branch_name

# Clean configuration file
If you want to remove any of the setting delete the file or remove the setting from the .gitconfig file.
rm /home/username/.gitconfig
echo '' > /home/username/.gitconfig
