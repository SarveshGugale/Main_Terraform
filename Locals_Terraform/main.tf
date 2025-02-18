provider "aws" {
    region = "us-east-1"
}

locals {
    staging_env = "staging"
}

resource "aws-vpc" "staging-vpc" {
    cidr_block = "10.5.0.0/16"
    tags = {
        Name = "${local.staging_env}-vpc-tag"
    }
}

resource "aws-subnet" "staging-subnet" {
    vpc_id = aws_vpc.staging-vpc.id
    cidr_block = "10.5.0.0/16"
    tags = {
        Name =  "${local.staging_env}-subnet-tag"                            
    }
}

resource "aws_instance" "aws_example" {
    ami = "ami-49bv890341nbb5c"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.staging-staging.id

    tags = {
        Name = "${local.staging_env} - Terraform Ec2"
    }
}