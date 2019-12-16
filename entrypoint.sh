#!/bin/sh

set -e

echo "$INPUT_SERVICE_KEY" | base64 --decode > "$HOME"/gcloud.json

if [ "$INPUT_ENV" ]
then
    ENVS=$(cat "$INPUT_ENV" | xargs | sed 's/ /,/g')
fi

if [ "$INPUT_ALLOW_UNAUTH" ]
then
    ALLOW_UNAUTH_FLAG="--allow-unauthenticated"
else
    ALLOW_UNAUTH_FLAG="--no-allow-unauthenticated"
fi

if [ "$INPUT_MEMORY" ]
then
    MEMORY_FLAG="--memory=$INPUT_MEMORY"
fi

if [ "$INPUT_CONCURRENCY" ]
then
    CONCURRENCY_FLAG="--concurrency=$INPUT_CONCURRENCY"
fi


if [ "$ENVS" ]
then
    ENV_FLAG="--set-env-vars=$ENVS"
else
    ENV_FLAG="--clear-env-vars"
fi

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT"

gcloud beta run deploy "$INPUT_SERVICE" \
  --project "$INPUT_PROJECT" \
  --image "$INPUT_IMAGE" \
  --region "$INPUT_REGION" \
  --platform managed \
  ${ALLOW_UNAUTH_FLAG} \
  ${MEMORY_FLAG} \
  ${CONCURRENCY_FLAG} \
  ${ENV_FLAG}
