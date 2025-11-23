--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
User data script & output block
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# main.tf
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "new_web" {
  ami = var.my_ami
  instance_type = var.my_instance
  key_name = var.my_key
  vpc_security_group_ids = var.my_sg
  #heredoc
user_data = <<-EOF
             #!/bin/bash
             sudo yum update
             sudo yum install httpd -y
             sudo systemctl start httpd
             cd /var/www/html
             echo "<h1>This is httpd server</h1>" > index.html
             EOF

    tags = {
      Name = "newserver"
    }
}

#IF you want to print launch server IP
output "name" {
  value = aws_instance.new_web.public_ip
}



# varible.tf
# Declaraction/define  and assignment

/*variable "my_ami" {
  description = "Enter ami id"    # No assignment
}*/
variable "my_ami" {
  default = "ami-0a716d3f3b16d290c"
}
variable "my_instance" {
  default = "t3.micro"                 # assignment
}
variable "my_key" {
  default = "server1"
}
variable "my_sg" {
  default = ["sg-0b96d9defb7beaca0"]
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Data Block
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# main.tf
provider "aws" {
  region = "eu-north-1"
}
# terraform import

resource "aws_instance" "aws_web" {
  ami = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0b96d9defb7beaca0"]
  key_name = "server1"
  tags = {
      Name = "newserver"
    }
}

/* # for importing security group
resource "aws_security_group" "aws_sg" {
  name = "server1"
  vpc_id = "vpc-037f501a25f7b79f6 "
#whil importing edit security group  
  ingress  {
    description ={
      to_port = 22
      from_port = 22
      protocol = "tcp"
      cider_blocks = ["0.0.0.0./0"]
    }
  ingress {
    description ={
      to_port = 80
      from_port = 80
      protocol = "tcp"
      cider_blocks = ["0.0.0.0./0"]
    }
  }
    egress {
        description ="allow alltraffic"
        to_port = 0
        from_port = 0
        protocol = -1
        cider_blocks =  ["0.0.0.0./0"]
  }
  lifecycle {
     create_before_destroy = true
  }
} */




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Terraform Import
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# main.tf


provider "aws" {
  region = "eu-north-1"
}
# terraform import

resource "aws_instance" "aws_web" {
  ami = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-0b96d9defb7beaca0"]
  key_name = "server1"
}


# in terminal run this command

 #   terraform import aws_instance.aws_web i-08c8ab3231d6d5375






--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
