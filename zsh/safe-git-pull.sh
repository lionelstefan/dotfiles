#!/bin/bash

# Get the current branch
current_branch=$(git symbolic-ref --short HEAD)

# Define the target branch
target_branch="staging"

# Check the command arguments
if [ "$1" == "staging" ]; then
  if [ "$current_branch" != "$target_branch" ]; then
    echo "Warning: You are on the '$current_branch' branch, not '$target_branch'."
    read -p "Are you sure you want to proceed? (y/n): " confirmation
    if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
      echo "Aborting the command."
      exit 1
    fi
  fi
fi

# Execute the original command if checks pass
git "$@"
