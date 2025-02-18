provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2_example" {
    ami = "ami-7767046d1677be5ao"
    instance_type = "t2.micro"

    tags = {
        Name = "Terraform Ec2"
    }
}

resource "null_resource" "null_resource_simple" {
    /*trigger = {

        id = timestamp()           // 1st time use id= aws_instance.ec2_example.id
    }*/

    provider "local-exec" {
        command = "echo Hello World"
    }
}