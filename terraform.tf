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
#  Data Block
resource "aws_instance" "new_web" {
  ami = var.my_ami
  instance_type = var.my_instance
  key_name = var.my_key
  vpc_security_group_ids = var.my_sg
  tags = {
    Name = "newserver"
  }
}


# to read the data from aws and it attaches the resource of aws to terraform
data "aws_security_group" "aws_sg" {
  name = "security-gp-nm"
  vpc_id = "vpc-94983848348"
  
}





--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Terraform Import
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# main.tf


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


# in terminal run this command

 #   terraform import aws_instance.aws_web i-08c8ab3231d6d5375
#    terraform import aws_security_group.aws_web i-08c8ab3231d6d5375






--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Backend block
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#main.tf

terraform {
  backend "s3" {
    bucket = "backenddd-s3-buckett"
    key = "terraform.tfstate"
    region = "eu-north-1"     # remote backend any region you want . not compulasary same as instance
  }
}

provider "aws" {
  region = "eu-north-1"      # resource block
}
resource "aws_instance" "my_web" {
  ami = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  key_name = "server1"
   tags = {
    Name = "webserver"
  }
    }


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Terraform Provisioner
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ex. This block runs a command on your local machine and saves the EC2 instance public IP into a file.(Using Privisioner)

# provisioner --> Local
resource "aws_instance" "my-web" {
  ami = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"
  key_name = "server1" # public-key

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }
  tags = {
    Name = "webserver"
  }

}



















--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


















