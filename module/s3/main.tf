provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "s3_bucket_template" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "s3_security_template" {
  bucket = var.bucket_name

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "s3_securty_template" {
  bucket = var.bucket_name
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}