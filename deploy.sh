#!/bin/bash
DOCKERHUB_USERNAME="ramaswamy12"
DEV_REPO="dev"
PROD_REPO="prod"
DOCKERHUB_PASSWORD="dckr_pat_W8WCZwTlaOGcNsEniO_3nRGe0Dc"
docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"

IMAGE_NAME="myreactimg"
IMAGE_TAG="latest"
if [[ CURRENT_BRANCH=$(git rev-parse --abbrev-ref master) ]]; then
  echo "Current branch: $CURRENT_BRANCH" 
  ./build.sh
  docker tag "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERHUB_USERNAME/$DEV_REPO:$IMAGE_TAG"
  docker push "$DOCKERHUB_USERNAME/$DEV_REPO:$IMAGE_TAG"
  echo "Docker image pushed to dev repo on DockerHub."
elif [[ CURRENT_BRANCH=$(git rev-parse --abbrev-ref dev) ]]; then
  echo "Current branch: $CURRENT_BRANCH" 
  ./build.sh
  docker tag "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERHUB_USERNAME/$PROD_REPO:$IMAGE_TAG"
  docker push "$DOCKERHUB_USERNAME/$PROD_REPO:$IMAGE_TAG"
  echo "Docker image pushed to prod repo on DockerHub."
else
  echo "Code error: Unsupported branch for deployment."
fi


