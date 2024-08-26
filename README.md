# Terraform Learning from zero to hero 

# This labs were guided by Sandbox Yangon. 

Lab Guide Instructions: Setting Up AWS Infrastructure with Terraform

# Lab Overview:

In this lab, you will use Terraform to create a basic AWS infrastructure that includes a Virtual Private Cloud (VPC), Internet Gateway (IGW), public and private subnets, and a route table. The infrastructure will be spread across multiple availability zones.

# Prerequisites:

Terraform installed on your machine.
AWS credentials configured (using aws configure or environment variables).
Basic understanding of AWS and Terraform.


# Details Steps 

1. Checking AWS Availability Zones
   - Use the aws_availability_zones data source to retrieve a list of available availability zones in the AWS region.
  
2. Creating a Virtual Private Cloud (VPC)
   - Define the VPC with a CIDR block. This VPC will act as the isolated network environment for deploying your AWS resources.

3. Creating an Internet Gateway (IGW)
   - Create an Internet Gateway and attach it to your VPC. This will allow resources in your public subnets to access the internet.

4. Creating a Public Route Table
   - Define a route table for public subnets, which routes traffic to the Internet Gateway.

5. Creating Public Subnets
   - Create public subnets across all availability zones in the VPC. These subnets will be associated with the public route table.

6. Associating Public Subnets with the Public Route Table
   - Associate each public subnet with the public route table to ensure they can route traffic to the internet.

7. Creating Private Subnets
   - Create private subnets across all availability zones. These subnets will be used for resources that do not require direct internet access.



# Git Repository Description
Repository Name: aws-terraform-infra

# Description: This repository contains Terraform code for provisioning a basic AWS infrastructure. It sets up a Virtual Private Cloud (VPC) with public and private subnets spread across multiple availability zones. The setup includes an Internet Gateway, a public route table, and associations for the public subnets. The infrastructure is designed to provide a scalable and secure environment for deploying applications in AWS.

# Repository Structure:

main.tf: Contains the primary Terraform configuration.
variables.tf: Defines the variables used in the Terraform configuration.
outputs.tf: (Optional) Defines the outputs for the Terraform configuration.
README.md: Provides an overview and instructions for using the Terraform code.

# Usage 
1. Clone the repo.
2. Initialize Terraform.
   # terraform init
3. Review the execution plan
   # terraform plan
4. Apply the configuration
   # terraform apply
5. Destory the infrastructure when no longer needed:
   # terraform destroy

# Variables

- `cidr_range`: The CIDR block for the VPC.
- `vpc_name`: The name of the VPC.
- `igw_name`: The name of the Internet Gateway.
- `public_route_name`: The name of the public route table.
- `cidr_range_for_public_subnet`: A list of CIDR blocks for the public subnets.
- `name_for_public_subnet`: A list of names for the public subnets.
- `cidr_range_for_private_subnet`: A list of CIDR blocks for the private subnets.
- `name_for_private_subnet`: A list of names for the private subnets.



