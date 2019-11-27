
# GCP cloud function with terraform

An example of deploying a hello world GCP cloud function with terraform.


# Initialisation 
- Install gcloud and Terraform
- Create your project on Gcloud 
- `./initialise.sh <PROJECT_ID> <SERVICE_ACCOUNT_NAME>` 
- update `terraform.tfvars` with your project id.  Note you dont need to edit the service account it has been copied by the script

# Create Environment

- `terraform init`
- `terraform plan`
- `terraform apply`

URL for functions are output from `terraform apply`


# Teardown environment

Do this to save money!

`terraform destroy`
