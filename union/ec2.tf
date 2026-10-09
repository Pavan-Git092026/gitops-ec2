provider "aws" {
  region = "ap-south-2"
}

# Dynamically fetch the latest Amazon Linux 2 AMI ID
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create the EC2 instance using the dynamic AMI data source
resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "Dynamic-AMI-Instance"
  }
}

output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.my_instance.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}
