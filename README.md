
# GCP cloud function with terraform

An example of deploying a hello world GCP cloud function with terraform.

# Initialisation 
- Install Gcloud and Terraform
- Create your project on Gcloud 
- Download service account credentials and save as per service account variable in `terraform.tfvars`

# Create Environment

- `terraform init`
- `terraform plan`
- `terraform apply`

URL for function is output from `terraform apply`


# Teardown environment

Do this to save money!

`terraform destroy`