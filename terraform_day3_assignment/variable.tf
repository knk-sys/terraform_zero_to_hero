

variable "vpc_name" {

}

variable "cidr_range" {
  # description = "Please provide the CIDR range for your VPC or Subnet"
}

variable "igw_name" {
    #description = "Please provide the Name for your IGW"
  
}
variable "availability_zone_public_subnet" {
    type = list(string)
}

variable "cidr_range_for_public_subnet" {
  type = list(string)
}

variable "name_for_public_subnet" {
    type = list(string)
  
}




variable "availability_zone_private_subnet" {
    type = list(string)
  
}


variable "name_for_private_subnet" {
    type = list(string)
  
}


variable "cidr_range_for_private_subnet" {
    type = list(string)
  
}



#for Route
variable "public_route_name" {
  
}

variable "private_route_name" {
  
}