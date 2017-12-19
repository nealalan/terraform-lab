# S3 BUCKETS OUTPUT
output "terraform_state_bucket_id" {
  value = "${aws_s3_bucket.terraform_state_bucket.id}"
}
output "terraform_state_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state_bucket.arn}"
}
# VPC OUTPUT 
output "neon_aluminum-vpc" {
  value = "${aws_vpc.neon_aluminum-vpc.id}"
}
