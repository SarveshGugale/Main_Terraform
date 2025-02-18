provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "Terraform ec2" {
    ami = "ami-0df8c184d5f6ae949"
    instance_type = var.instance_type

    tags = {
        Name = "Terraform Ec2"
    }
}

variable "instance_type" {
    description = "instance_type t2.micro"
    type = string
    default = "t2.micro"
}