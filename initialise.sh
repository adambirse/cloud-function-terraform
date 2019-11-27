#!/usr/bin/env bash

# Create service account
echo "Create service account"
gcloud config set project $1
gcloud iam service-accounts create $2 --description "My service account" --display-name "my service account"
gcloud iam service-accounts list


# Enable API's
echo "Enable API's - This will take a while"
gcloud services enable vpcaccess.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable sqladmin.googleapis.com

echo "Creating service permissions"
email=$2@$1.iam.gserviceaccount.com
echo ${email}


gcloud projects add-iam-policy-binding $1 \
  --member serviceAccount:${email} \
  --role roles/compute.admin

  gcloud projects add-iam-policy-binding $1 \
--member serviceAccount:${email} \
--role roles/cloudfunctions.admin

gcloud projects add-iam-policy-binding $1 \
--member serviceAccount:${email} \
--role roles/storage.admin

gcloud projects add-iam-policy-binding $1 \
--member serviceAccount:${email} \
--role roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding $1 \
--member serviceAccount:${email} \
--role roles/cloudsql.admin

echo "Creating and downloading service key"

gcloud iam service-accounts keys create ~/key.json \
   --iam-account ${email}

cp /$HOME/key.json terraform/service-account.json




