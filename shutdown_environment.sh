#!/bin/bash

echo "Exporting GCLOUD_PROJECT, GCLOUD_BUCKET, and GOOGLE_APPLICATION_CREDENTIALS"
export GCLOUD_PROJECT=$DEVSHELL_PROJECT_ID
export GCLOUD_BUCKET=$DEVSHELL_PROJECT_ID-media
export GOOGLE_APPLICATION_CREDENTIALS=key.json

echo "Deleting Cloud Spanner Instance, Database, and Table"
gcloud -q spanner instances delete quiz-instance

echo "Deleting Cloud Pub/Sub topic"
gcloud pubsub topics delete feedback

echo "Deleting quiz-account Service Account"
gcloud -q iam service-accounts delete quiz-account@$GCLOUD_PROJECT.iam.gserviceaccount.com
rm $GOOGLE_APPLICATION_CREDENTIALS

echo "Deleting Datastore/App Engine instance"
gcloud app create --region "europe-west"

echo "Deleting bucket: gs://$GCLOUD_BUCKET"
gsutil rm -r gs://$GCLOUD_BUCKET
