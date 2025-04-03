terraform {
  backend "s3" {
    bucket = "tp-backend"
    key = "terraform/remote_backend/statefile.tf"
    region = "us-east-1"
    dynamodb_table = "tp-remotestate"
  }
}