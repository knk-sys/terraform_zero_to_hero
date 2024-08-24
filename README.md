# terraform_zero_to_hero
Terraform Learning from zero to hero and this labs were guided by Sandbox Yangon.

# Lab Guide Instructions: Setting Up a VPC with Public and Private Subnets using Terraform

1. Declare Data Source for Availability Zones
   - Use the aws_availability_zones data source to get the list of available availability zones in your region. This data source will be used to distribute subnets across different zones

2. Create a Virtual Private Cloud (VPC)
   - Define the VPC with a specified CIDR block. The VPC will serve as the isolated network environment for your infrastructure

3. Create an Internet Gateway (IGW)
   - Create an Internet Gateway to allow public internet access to resources in the public subnets

4. Attach the Internet Gateway to the VPC
   - Attach the Internet Gateway to the VPC, enabling resources within the VPC to connect to the internet.

5. Create Public Subnets
   - Create one public subnet per availability zone. Subnets will be distributed across the available zones based on the data source defined earlier

6. Create Private Subnets
   - Similarly, create private subnets in each availability zone. These subnets won't have direct internet access
  
7. Create a Public Route Table
   - Define a route table for public subnets, which routes traffic to the Internet Gateway

8. Associate Public Subnets with the Public Route Table
   - Associate each public subnet with the public route table to ensure they can route traffic to the internet

9. Create a Default Private Route Table
   - Create a default route table for private subnets, which won't have direct internet access


# Summary
This Terraform configuration sets up a VPC with public and private subnets across multiple availability zones. 
The public subnets are connected to an internet gateway, allowing resources within them to have internet access. 
Private subnets are isolated and do not have direct internet access.

          
