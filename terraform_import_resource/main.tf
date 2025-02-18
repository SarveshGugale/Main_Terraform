terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#terraform import aws_s3_bucket.my_test_bucket sarvesh-demo1 

resource "aws_s3_bucket" "my_test_bucket" {
bucket = "sarveshdemo1"
tags = {
    "name" = "test bucket"
  }
}


#terraform import aws_s3_bucket_acl.example sarvesh-demo1 
resource "aws_s3_bucket_acl" "example" {
bucket = aws_s3_bucket.my_test_bucket.id
}
