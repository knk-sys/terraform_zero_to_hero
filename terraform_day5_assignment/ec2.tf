#Generating keypair for EC2
resource "tls_private_key" "ec2key" {
    algorithm = "RSA"
    rsa_bits = 4096
  
}


 
# Store private key in local
resource "local_file" "private_key" {
    filename = "${path.root}/private_key_EC2.pem"
    content  = tls_private_key.ec2key.private_key_pem

    # Use a provisioner to change file permissions after the file is created
    provisioner "local-exec" {
        command = "chmod 400 ${path.root}/private_key_EC2.pem"
    }
}


#Place public key into EC2
resource "aws_key_pair" "key-pair" {
    key_name = "public_key.pub"
    public_key = tls_private_key.ec2key.public_key_openssh
}


#Creating Security Group
resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.Pro-VPC.id
  name = "Test-1"
  tags = {
    Name = "sg-1-EC2"
  }  
}

#Creating Security Group Rules (Ingress and Engress)
resource "aws_vpc_security_group_ingress_rule" "allow_engress_ipv4" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress_ssh_ipv4" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = aws_vpc.Pro-VPC.cidr_block
  from_port = 22
  to_port = 22
  ip_protocol       = "tcp"
}


#Creating AWS Instance EC2
resource "aws_instance" "Server1" {
    ami = local.selected_ami
    subnet_id = aws_subnet.pub-subnets["pub-subnet-1"].id
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.sg1.id  ]
    key_name = aws_key_pair.key-pair.key_name

    tags = {
      Name = "EC2_Testbed"
    }
  
}

#Creating Elastic IP for EC2
resource "aws_eip" "eip_ec2" {
  domain = "vpc"
}

#binding Elastic IP to EC2
resource "aws_eip_association" "eip_to_ec2" {
instance_id = aws_instance.Server1.id
allocation_id = aws_eip.eip_ec2.id
}

#Requesting AMI from User for EC2 Instance
variable "Operating_System" {
    description = "Choose your operations system: [\"Ubuntu\" , \"Amazon Linux 2 \" , \"Redhat\" ]"
    validation {
      condition = var.Operating_System == "Ubuntu" || var.Operating_System == "Amazon Linux 2" || var.Operating_System == "Redhat" 
      error_message = "Please choose provided OS"
    }
  
}

#Mapping user input and AMI value
locals {
  os_to_ami = {
    "Ubuntu" = "ami-01811d4912b4ccb26"
    "Amazon Linux 2" = "ami-0ac0f5ac9a9b402fa"
    "Redhat" = "ami-0b748249d064044e8"
  }

  ssh_user_name = {
    "ami-01811d4912b4ccb26" = "ubuntu"
    "ami-0ac0f5ac9a9b402fa" = "ec2-user"
    "ami-0b748249d064044e8" = "ec2-user"
  }
  


  selected_ami = lookup(local.os_to_ami, var.Operating_System, )

  selected_ssh_username = lookup(local.ssh_user_name, local.selected_ami)
}

#output ssh command to login instances
output "ssh_command" {
  value = " ssh -i ${local_file.private_key.filename} ${local.selected_ssh_username}@${aws_eip.eip_ec2.public_ip} "
  
}