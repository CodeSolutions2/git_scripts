#!/bin/bash

# ./creer_repo.sh


export val=$(echo "X1")

if [[ $val == "X0" ]]
then

    # ------------------- Clone an existing repository -------------------

    # Step 0: get Personal Access Token (PAT) from 
    export PAT=$(echo "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")
    
    # ---------------------------------------------

    gh auth login --with-token $PAT | gh auth login --scopes "read:org"
    
    # ------------------- 
    
fi
    


# ---------------------------------------------



export val=$(echo "X0")

if [[ $val == "X0" ]]
then

    # Step 1: Set repo and path variables 
    
    # ***** CHANGE *****
    export NOMDEREPO=$(echo "modify_docx_package")  
    # ***** CHANGE *****
    
    # ***** CHANGE *****
    export folder_path_outside_git_dir=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git2")
    
    export git_dir_folder_path=$(echo "/home/oem2/Documents/PROGRAMMING/Github_analysis_PROJECTS/PYPI/Automatic_CV/git2/$NOMDEREPO")
    # ***** CHANGE *****
    
fi
    


# ---------------------------------------------



export val=$(echo "X0")

if [[ $val == "X0" ]]
then

    # Start over add and commit history
    # git reset *
    # git status
    
    
    export OWNER=$(echo "DevopsPractice7")
    export REPO=$(echo "modify_docx_package")
    export WORKFLOW_ID=$(echo "release.yml")
    
    # -------------------
    gh workflow run "Upload Python Package"
    # could not create workflow dispatch event: HTTP 422: Workflow does not have 'workflow_dispatch' trigger (https://api.github.com/repos/DevopsPractice7/modify_docx_package/actions/workflows/61171940/dispatches)
    
    # https://docs.github.com/rest/reference/actions#create-a-workflow-dispatch-event
    
    # -------------------
    
    
    # -------------------
    # Print workflow runs  
    gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/$OWNER/$REPO/actions/runs
    
    # OR
    
    curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $PAT"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/actions/runs
    # -------------------
    
    # configure your GitHub Actions workflow to run when the workflow_dispatch webhook event occurs. The inputs are configured in the workflow file
    
    
    # Need 0. workflow_dispatch webhook event
    
    # event will only trigger a workflow run if the workflow file is on the default branch.
    
    # on: workflow_dispatch

    
    # Need 1. GitHub Actions workflow
    
    
    
    
  curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $PAT"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_ID/dispatches \
  -d '{"ref":"main"}'
    #{
 # "message": "No ref found for: Upload Python Package",
#  "documentation_url": "https://docs.github.com/rest/reference/actions#create-a-workflow-dispatch-event"
#}

fi

# ---------------------------------------------


