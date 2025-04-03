resource "aws_s3_bucket" "tp_s3_bucket" {
  bucket = var.s3bucket_name

  tags = {
    Env = var.s3environment
  }
}