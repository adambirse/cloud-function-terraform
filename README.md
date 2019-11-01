
# GCP cloud function with terraform

An example of deploying a hello world GCP cloud function with terraform.



# Initialisation 
- Install Gcloud and Terraform
- Create your project on Gcloud 

## Create service account


- `gcloud config set project cloud-functions-terraform`
- `gcloud iam service-accounts list`
- `gcloud iam service-accounts create <SERVICE_ACCOUNT_NAME>`
- `gcloud iam service-accounts list` to get the <SERVICE_ACCOUNT_EMAIL>

## Add service permissions

- `gcloud projects add-iam-policy-binding cloud-functions-terraform \
  --member serviceAccount:<SERVICE_ACCOUNT_EMAIL> \
  --role roles/compute.admin`
  
- `gcloud projects add-iam-policy-binding cloud-functions-terraform \
--member serviceAccount:<SERVICE_ACCOUNT_EMAIL> \
--role roles/cloudfunctions.admin`

- `gcloud projects add-iam-policy-binding cloud-functions-terraform \
--member serviceAccount:<SERVICE_ACCOUNT_EMAIL> \
--role roles/storage.admin`

- `gcloud projects add-iam-policy-binding cloud-functions-terraform \
--member serviceAccount:<SERVICE_ACCOUNT_EMAIL> \
--role roles/iam.serviceAccountUser`

## Create and download service key

- `gcloud iam service-accounts keys create ~/key.json \
   --iam-account <SERVICE_ACCOUNT_EMAIL>`
   
- `cp /Users/<USER_HOME>/key.json service-account.json`


# Create Environment

- `terraform init`
- `terraform plan`
- `terraform apply`

URL for function is output from `terraform apply`


# Teardown environment

Do this to save money!

`terraform destroy`
