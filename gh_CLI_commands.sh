# ---------------------------------------------
# gh : Github API command line tool
# https://cli.github.com/manual
# sudo zypper install gh
# ---------------------------------------------


login_to_gh(){

    # Personal Access Token (PAT)
    export PAT=$(echo "ghp_XXXXXXXXXX")


    # The GITHUB_TOKEN secret is a GitHub App installation access token. 
    # https://cli.github.com/manual/gh_auth_login
    # sudo echo "ghp_XXXXXXXXXX" >> GH_TOKEN.txt
    # gh auth login --with-token < GH_TOKEN.txt

    # ---------------------------------------------

 # The minimum required scopes for the token are: repo, read:org, and gist.
 gh auth login --with-token $PAT | gh auth login --scopes "read:org"

 # OR
 	
 gh auth login --with-token ghp_XXXXXXXXXX | gh auth login --scopes "read:org"

 # OR

 # This allows for web interface sign-in without prompts (it seems to be equivalent to gh auth login --web -h github.com)
 gh auth login --with-token ghp_XXXXXXXXXX | gh auth login --scopes "copilot"

 # OR

 !gh auth login --web -h github.com
 

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
    export username=$(echo "CodeSolutions2")

    export NOMDEREPO=$(echo "mod_docx")

    # Create the first release
    gh release create --repo $username/$NOMDEREPO --title "Version 10" --notes "Correction of errors: incorrect indentation line 242." 0.1.0
    
}


# ---------------------------------------------




setup_github_copilot_cli(){

 	# https://cli.github.com/manual/

	# Main installation page: https://cli.github.com/
 
  	# ---------------------------------------------
   
	# Check operating system version
	cat /etc/*-release
 	# Kaggle has Ubuntu

	# ---------------------------------------------

 	# Installation page for Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
 
	!type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	!curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

	# ---------------------------------------------

	!sudo apt -y update

	# ---------------------------------------------

	!sudo apt -y install gh
	
 	# ---------------------------------------------

	# Go to User Icon - Copilot - Fill out form
	# https://docs.github.com/en/copilot/configuring-github-copilot/configuring-github-copilot-settings-on-githubcom

GitHub Copilot is now ready to pair!
Add it to your editor and start building
Install the GitHub Copilot extension
To use GitHub Copilot, you first need to install the GitHub Copilot extension. To install for your preferred code editor, check out these Getting Started guides:

Visual Studio Code
Visual Studio
JetBrains
Neovim

If you have the extension already installed for your code editor and have it open, please restart your editor in order to access GitHub Copilot.

Having problems installing? Visit the Feedback forum. https://github.co/copilot-feedback

Tip: Don’t see your code editor? We currently only support the editors listed above. We’re constantly looking to expand the editors we support, so stay tuned.

Go to Billing and plans in your account settings to manage your GitHub Copilot subscription. 
https://github.com/settings/billing/summary

 # ---------------------------------------------

# Generated a token

admin:org, admin:public_key, copilot, project, admin:gpg_key, admin:ssh_signing_key

# ---------------------------------------------

 # Log into gh auth login

 # Way 0: it did not work
 !sudo echo "ghp_XXXXXXXXXX" >> GH_TOKEN.txt
 !gh auth login --with-token < GH_TOKEN.txt
 !rm GH_TOKEN.txt

 # Returns this error, if a token is used:
 
   ]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\
  ✗ Error: No valid OAuth token detected

  To get started with GitHub Copilot in the CLI, please run: gh auth login --web -h github.com to authenticate via web browser.

 
 # Way 1: WORKED!
 # This allows for web interface sign-in without prompts (it seems to be equivalent to gh auth login --web -h github.com)
 !gh auth login --with-token ghp_XXXXXXXXXX | gh auth login --scopes "copilot"

 # Returns what seems to be a correct response, but I can not see the correct output:
 
  ]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\]11;?\78
? Allow GitHub to collect optional usage data to help us improve? This data does not include your queries.  [Use arrows to move, type to filter]
> Yes
  No
  
  # ---------------------------------------------

  # Install the Copilot in the CLI extension
  !gh extension install github/gh-copilot
  
  # ✓ Installed extension github/gh-copilot

  # ---------------------------------------------

  # Update Copilot in the CLI
  !gh extension upgrade gh-copilot
  
  [copilot]: already up to date
✓ Successfully upgraded extension

  # ---------------------------------------------

 # Instructions for how to use GitHub Copilot
 # https://docs.github.com/en/copilot/github-copilot-in-the-cli/using-github-copilot-in-the-cli
 
  # Use Copilot
  
  !gh copilot SUBCOMMAND

  # Ask that copilot explain a certain code command
  !gh copilot explain "sudo apt-get"

  # Ask that copilot give you the command to install git
  !gh copilot suggest "Install git"

  # ---------------------------------------------
  
  # ---------------------------------------------

  # ---------------------------------------------

  # ---------------------------------------------

  # ---------------------------------------------

}


# ---------------------------------------------

using_github_codespaces(){

	# https://docs.github.com/en/codespaces/managing-your-codespaces/managing-your-account-specific-secrets-for-github-codespaces

Settings - Codespaces - Codespaces Secrets
}




# ---------------------------------------------

# Generate a secret name 
gh secret set SECRET_NAME --body "" --no-store

# ---------------------------------------------


# ---------------------------------------------


# ---------------------------------------------


# ---------------------------------------------

