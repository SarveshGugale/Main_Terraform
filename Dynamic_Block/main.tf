provider "aws" {
    region = "us-east-1
}

locals{
ingress_rule = [{
    port = 443
    description = "Ingress rule 443"
},

{
port = 22
    description = "Ingress rule 22"
}]
}

resource "aws_instance" "ec2_example" {
    ami = "ami-55679b5c2"
    instance_type = "t2.micro"
    key_name = "aws_key"
    vpc_security_group_ids = [aws_security_group_main.id]
}


resource "aws_security_group_main"
egress = [
    {
        cidr_block = ["0.0.0.0/0"]
        description = ""
        from_port = 0
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "-1"
        security_groups = []
        self = false
        to_port = 0
    }
]

dynamic "ingress" {
     for_each = local.ingress_rules

        content {
             description = Ingress.value.description
             from_port = Ingress.value.port
             to_port = Ingress.value.port
             protocol = "tcp"
             cidr_block = ["0.0.0.0/24"]
            }
        }
    }

    resource "aws_key_pair" "devloper" {
        key_name = "aws_key"
        public_key = "ssh-rsa AAAB4NzaClyc2EAAAAAAmlknbzksopPPlkIIUNBAS"
    }



