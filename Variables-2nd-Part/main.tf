provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2_example" {
    ami = "ami-07674677beg50" 
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