#!/bin/bash


# -------
# RUN IT
# -------
# cd /home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/Git_scripts
# ./gh_API_commands.sh


# ---------------------------------------------
# Log-in with gh
# ---------------------------------------------
export val=$(echo "X1")

if [[ $val == "X0" ]]
then
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

fi

# ---------------------------------------------

# lister des permissions
# curl -si https://api.github.com/user -H "Authorization: token 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" | grep -i '^x-oauth'

# curl -si https://api.github.com/user -H "Authorization: token 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" -H "x-oauth-scopes: repo"

# curl -si https://api.github.com/users/j622amilah -H "Authorization: token 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" -H "x-oauth-scopes: repo"

# Git version
# gh --version

# ---------------------------------------------

# curl --request POST --url https://api.github.com/repos/${{ github.repository }}/issues --header 'authorization: Bearer ${{ secrets.GITHUB_TOKEN }}' --header 'content-type: application/json' --data '{"title": "Automated issue for commit: ${{ github.sha }}", "body": "This issue was automatically created by the GitHub Action workflow **${{ github.workflow }}**. \n\n The commit hash was: _${{ github.sha }}_."}' --fail

# ---------------------------------------------



# ---------------------------------------------
# Create a new remote repository and clone it locally
# ---------------------------------------------
export val=$(echo "X0")

if [[ $val == "X0" ]]
then

    # export NOMDEREPO=$(echo "mod_docx")
    export NOMDEREPO=$(echo "Git_scripts")
    
    
    # Create a new remote repository and clone it locally
    gh repo create $NOMDEREPO --public --clone

    # gh repo list
    
    # Create a README
    sudo echo $NOMDEREPO >> README.md
    # OU
    # sudo touch README.md
    # OU
    # sudo echo $NOM_DE_REPO | cat >> README.md

fi

# ---------------------------------------------




# ---------------------------------------------
# Create a new release/tag for published code
# ---------------------------------------------
export val=$(echo "X1")

if [[ $val == "X0" ]]
then
    # Organization account
    export username=$(echo "DevopsPractice7")

    export NOMDEREPO=$(echo "mod_docx")

    # Create the first release
    gh release create --repo $username/$NOMDEREPO --title "Version 10" --notes "Correction of errors: incorrect indentation line 242." 0.1.0

fi

# ---------------------------------------------
