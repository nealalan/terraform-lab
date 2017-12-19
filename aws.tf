### USE:
# $ terraform init
# $ terraform plan
# $ terraform destroy   # remove all resources from AWS
# $ terraform apply -var-files="secret.tfvars"
#
# Part 1 AWS Access
# https://console.aws.amazon.com/iam/home?#/security_credential
#
# Create a file called secret.tfvars and add the following two records:
#  aws_access_key = ""
#  aws_secret_key = ""
#
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region 	= "${var.region}"
}

### HOW DO WE GET THE terraform.tfstate file in?
# $ aws s3 mv terraform.rfstate s3://my-tf-test-bucket-nad --region us-east-2 --profile ?
#
terraform {
   backend "s3" {
    bucket = "tfstate-neonaluminum"
       key = "terraform.tfstate"
    region = "us-east-2"
  }
}

#data "terraform_remote_state" "network" {
#  backend = "s3"
#  config {
#    bucket = "tfstate-neonaluminum"
#    key    = "terraform.tfstate"
#    region = "us-east-2"
#  }
#}
