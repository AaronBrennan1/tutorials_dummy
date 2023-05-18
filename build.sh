#!/bin/bash

DEST_REPO=$1
DEST_REPO_TOKEN=$2
FILE_PATHS=$3

# Clone the destination repository
git clone https://AaronBrennan1:$DEST_REPO_TOKEN@github.com/$DEST_REPO.git

# Split the destination repository into owner and name
IFS='/' read -ra ADDR <<< "$DEST_REPO"
DEST_REPO_OWNER=${ADDR[0]}
DEST_REPO_NAME=${ADDR[1]}

# Change the current directory to the destination repository
cd $DEST_REPO_NAME

# Set up git config
git config user.name "GitHub Action"
git config user.email "action@github.com"

# Iterate over each file path
for FILE_PATH in $FILE_PATHS
do
  # Create the target directory in the destination repository
  mkdir -p "stable/tutorials/$(dirname "$FILE_PATH")"
  
  # Copy the file to the target directory in the destination repository
  cp "../$FILE_PATH" "stable/tutorials/$FILE_PATH"

 done

# Add, commit and push the files to the destination repository
git add .
git commit -m "Sync files from source repo" || echo "No changes to commit"
git push origin main
