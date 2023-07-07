#!/bin/bash


# ---------------------------------------------


export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    export directoire_actuel=$(pwd)

    path_au_fichier=$(echo "${directoire_actuel}/${NOMDEREPO}export")
    echo $path_au_fichier

    # Copy all files into this path

    # Get file list of current path
    ls | sed 's/'$NOMDEREPO'//g' | sed 's/file_listgit//g' | sed '/^$/d' > file_listgit

    for filename in $(cat file_listgit)
    do
        cp $filename $path_au_fichier
    done

    cd $path_au_fichier
else
    echo "NO : Arrange files"
fi

# ---------------------------------------------

export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    git init
else
    echo "NO : git init"
fi

# ---------------------------------------------

export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    # Voir votre information : 
    # git config --list --show-origin

    export username=$(git config user.name)
    export useremail=$(git config user.email)

    # ---------------------------------------------

    export URL=$(echo "https://github.com/${username}/${NOMDEREPO}.git")
    # OU
    # export URL=$(echo "git@github.com:${username}/${NOMDEREPO}.git")

    # ---------------------------------------------

    git config --global remote.origin.url $URL

    git config --global safe.directory $directoire_actuel
    
else
    echo "NO : Set environmental variables"
fi
# ---------------------------------------------

export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    
    
    # sudo git add .     # (if you want to add everything in the local repository)
    # OR
    # sudo git add README.md

    #export datetime_now=$(echo `date '+%F_%H:%M:%S'`)
    #sudo git commit -m "Files : $datetime_now"

    # sudo git remote add origin $URL ***OU*** git config --global remote.origin.url $URL

    sudo git push -u origin master
    
else
    echo "NO : PUSH files"
fi





# go to file directory before  
cd /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics


# Run this outside the git directory folder
git init

# ---------------------------------------------

git config --list --show-origin

# ---------------------------------------------

export username=$(git config user.name)
export useremail=$(git config user.email)

export NOMDEREPO=$(echo "automatic_GCP_ingestion")

export URL=$(echo "https://github.com/${username}/${NOMDEREPO}.git")
# OU
export URL=$(echo "git@github.com:${username}/${NOMDEREPO}.git")

git config --global remote.origin.url $URL



sudo git clone $URL

sudo chmod 777 ${NOMDEREPO}/

# ---------------------------------------------

sudo cp -a /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics/3_Google_Data_Analytics_Capstone_Complete_a_Case_Study/. /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics/${NOMDEREPO}

cd $NOMDEREPO

# ---------------------------------------------

# should be in git directory
sudo git add .     # (if you want to add everything in the local repository)
# OR 
sudo git filename

git commit -m "comment"

git push -u origin master


git reset --hard ${NOMDEREPO}


export val=$(echo "X0")

if [[ $val == "X0" ]]
then

    # ------------------- Clone an existing repository -------------------

    # Step 0: get Personal Access Token (PAT) from 
    export PAT=$(echo "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")
    
    # Step 0: cd to folder 
    git init
    
    
    # View configuration file
    git config --list --show-origin
    
    
    # Edit configuration file
    
    
    
    export username=$(git config user.name)
    export useremail=$(git config user.email)

    # ******* Change *******
    export NOMDEREPO=$(echo "modify_docx_package")

    export URL=$(echo "https://github.com/${username}/${NOMDEREPO}.git")
    # OU
    export URL=$(echo "git@github.com:${username}/${NOMDEREPO}.git")

    git config --global remote.origin.url $URL
    
    sudo git clone $URL
     
else
    echo "NO : Login"
fi

# ---------------------------------------------




export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    export directoire_actuel=$(pwd)

    path_au_fichier=$(echo "${directoire_actuel}/${NOMDEREPO}export")
    echo $path_au_fichier

    # Copy all files into this path

    # Get file list of current path
    ls | sed 's/'$NOMDEREPO'//g' | sed 's/file_listgit//g' | sed '/^$/d' > file_listgit

    for filename in $(cat file_listgit)
    do
        cp $filename $path_au_fichier
    done

    cd $path_au_fichier
else
    echo "NO : Arrange files"
fi

# ---------------------------------------------

export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    git init
else
    echo "NO : git init"
fi

# ---------------------------------------------


export val=$(echo "X0")

if [[ $val == "X0" ]]
then
    
    
    # sudo git add .     # (if you want to add everything in the local repository)
    # OR
    # sudo git add README.md

    #export datetime_now=$(echo `date '+%F_%H:%M:%S'`)
    #sudo git commit -m "Files : $datetime_now"

    # sudo git remote add origin $URL ***OU*** git config --global remote.origin.url $URL

    sudo git push -u origin master
    
else
    echo "NO : PUSH files"
fi





# go to file directory before  
cd /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics


# Run this outside the git directory folder
git init

# ---------------------------------------------

git config --list --show-origin

# ---------------------------------------------



# ---------------------------------------------



# ---------------------------------------------

sudo git clone $URL

sudo chmod 777 ${NOMDEREPO}/

# ---------------------------------------------

sudo cp -a /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics/3_Google_Data_Analytics_Capstone_Complete_a_Case_Study/. /home/oem2/Documents/COURS_ONLINE/Spécialisation_Google_Data_Analytics/${NOMDEREPO}

cd $NOMDEREPO

# ---------------------------------------------

# should be in git directory
sudo git add .     # (if you want to add everything in the local repository)
# OR 
sudo git filename

git commit -m "comment"

git push -u origin master


git reset --hard ${NOMDEREPO}



# ---------------------------------------------



export val=$(echo "X1")

if [[ $val == "X0" ]]
then

    # ------------------- 
    # Push with basic commands  : error messages say that this does not work anymore
    # one needs to be on a branch to push data.   **** DO NOT USE ****
    # ------------------- 
    # Should be outside the git directory
    # cd $folder_path_outside_git_dir
    
    # Initialize the local directory and set the initial branch name to main
    # git init
    
    # Should be in git directory when pushing files
    # cd $git_dir_folder_path
    
    # git add .     # (if you want to add everything in the local repository that was specified in the config file)
    # OR 
    # git filename
    
    # git commit -m "comment"
    
    # git push -u origin master
    
    # I put 'git push -u origin master' 
    # error: failed to push some refs to 'https://github.com/DevopsPractice7/modify_docx_package.git'
    # error: src refspec master does not match any
    # This error can occur for different reasons. The most likely reason this error will occur is that the master branch does not exist. Perhaps you cloned a new repository and the default branch is main , so there's no master branch when you try to push for it.
    # ------------------- 
    
    
    # Start over add and commit history
    # git reset *
    # git status

fi

# ---------------------------------------------






# --------------------- This was correct before, now it is wrong ---------------------
# Initialize the local directory and set the initial branch name to main
# git init -b $branch_name
# git init -b $3

# Should be in the git directory when pulling files
# cd $git_dir_folder_path_TEMP
# cd $2
# --------------------- 

