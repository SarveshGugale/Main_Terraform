provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2_example" {
    ami = ami-7789b5435cb"
    instance_type = "t2.micro"
    count = 1
     
     tags = {
        Name = "Terraform_Ec2"
     }
}
//count
/* resource "iam_user" "example" {
    count = length(var.user_names)
    name = var.user_names(count.index)
} */


/* //for_each       
resource "aws_iam_user" "example" {
    for_each = var.user_names
    name = each.value
} */

//for
output "print_the_names" {
    value = [for name in var.user_names : name]
}
 
variable "user_names" {
    description = "iam_user"
    type = List(string)              //in for each use set or map in type
    default = ["user1","user2","user3","user4"]
}