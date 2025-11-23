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
