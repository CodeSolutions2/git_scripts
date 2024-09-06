#!/bin/bash

# To create a GitHub pull request to contribute your project to another project, follow these steps:

# [0] Fork the target project's repository.

# [1] Go to forked repository: https://github.com/YOUR_REPO_OwnerName/TARGET_REPO_RepoName

# [2] Create a codespace: YOUR_REPO_OwnerName/TARGET_REPO_RepoName

# [3] Create a new branch, the new branch is called newBranch
git branch newBranch

# [4] Change the branch to the branch named newBranch
git checkout newBranch

# See all branches. Confirm that the new branch was added, and that the newBranch is selected
git branch 

# [5] Make the necessary changes and commit them to your branch. In the example, I am submitting a webapp index.html and README.md file.

# Make a folder to add to the TARGET_REPO_RepoName
mkdir folderName_to_add_to_TARGET_REPO_RepoName

echo '' > folderName_to_add_to_TARGET_REPO_RepoName/index.html
# copy-paste source index.html into empty file

echo '' > folderName_to_add_to_TARGET_REPO_RepoName/README.md
# copy-paste source README.md into empty file

# [6] Add changes to staging area.
git add .

# [7] Commit changes to forked repository [YOUR_REPO_OwnerName/TARGET_REPO_RepoName]
git commit -m "Updating repository"

# [8] Push your branch to your forked repository on GitHub.
git push --set-upstream origin newBranch

# [9] Finished with codespace. Delete the codespace.
gh codespace delete --all

# Confirm that the codespace is deleted at https://github.com/codespaces.

# [10] Go back to your forked repository: https://github.com/YOUR_REPO_OwnerName/TARGET_REPO_RepoName

# [11] Click on 'Pull-Request - comparing changes'. Select your branch with the changes and provide a detailed description of your contribution. A submission form will open such that you can type a message to the person that approves the GitHub repository changes.

# [12] Wait for the project maintainers to review and potentially merge your pull request. Go to the pull request page to view any new updates: https://github.com/TARGET_REPO_OwnerName/TARGET_REPO_RepoName/pull/XXXX .

