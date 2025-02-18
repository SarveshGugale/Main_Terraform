provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "jenkins_sg" {
  name_prefix = "jenkins-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-SG"
  }
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-053a45fff0a704a47" 
  instance_type = "t2.medium"
  key_name      = "SarveshTerraform-Jenkins"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
              <<-EOF
              #!/bin/bash
              # Update the package index
              apt update -y

              # Install OpenJDK 17
              apt install -y openjdk-17-jre-headless

              # Add Jenkins GPG key and repository
              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" > /etc/apt/sources.list.d/jenkins.list

              # Update the package index again after adding Jenkins repository
              apt update -y

              # Install Jenkins
              apt install -y jenkins

              # Start and enable Jenkins
              systemctl start jenkins
              systemctl enable jenkins
              EOF

  tags = {
    Name = "Jenkins-Server"
  }

  depends_on = [aws_security_group.jenkins_sg]  # Correct place for depends_on
}

output "my_console_output" {
    value = aws_instance.jenkins_server.public_ip
}