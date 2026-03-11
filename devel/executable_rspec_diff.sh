#!/bin/bash

# Set default branch name
branch_name="${1:-staging}"

# Get changed files with grep for _spec.rb extension
changed_specs=$(git diff --name-only --diff-filter=d "$branch_name" | grep _spec.rb)

# Check if any changed specs found
if [[ -z "$changed_specs" ]]; then
  echo "No changed _spec.rb files found between HEAD and $branch_name."
  exit 0
fi

echo "List of changed spec files:"
echo "$changed_specs"

# Run rspec with all changed specs
bundle exec rspec --format progress $changed_specs

echo "RSpec tests completed for changed _spec.rb files."
