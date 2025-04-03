terraform {
  backend "s3" {
    bucket = module.backend_s3_bucket.s3bucket_name
    key = "terraform/remote_backend/statefile.tf"
    region = "us-east-1"
  }
}