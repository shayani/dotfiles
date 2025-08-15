#!/bin/bash

# Colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

echo "Stopping all running Docker containers..."

RUNNING_CONTAINERS=$(docker ps -q)

if [ -z "$RUNNING_CONTAINERS" ]; then
  echo "No running containers to stop."
  exit 0
fi

for container_id in $RUNNING_CONTAINERS; do
  container_name=$(docker inspect --format='{{.Name}}' "$container_id" | sed 's,^/,,g')
  echo -n "Stopping container: $container_name..."
  if docker stop "$container_id" > /dev/null; then
    echo -e " [${GREEN}CHECK${NC}]"
  else
    echo -e " [${RED}FAIL${NC}]"
  fi
done

echo "All done."
