#
# S3 Access Logs
resource "aws_s3_bucket" "log_bucket" {
  bucket = "log-bucket-nad"
  acl    = "private"
  tags {
    management = "terraform"
  }
}
# S3 BUCKET TO HOLD THE terraform.tfstate FILE
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "tfstate-neonaluminum"
  acl = "private"
  tags {
    management = "terraform"
  }
}
