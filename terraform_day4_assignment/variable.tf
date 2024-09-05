variable "vpc" {
  type = object({
    cidr_block = string
    Name       = string
  })
  default = {
    cidr_block = "10.10.0.0/16"
    Name       = "VPC-Thor"
  }
}

variable "public-subnet" {
  type = map(object({
    cidr_block = string
    zone       = string
    Name       = string
  }))
  default = {
    "pub-subnet-1" = {
      cidr_block = "10.10.1.0/24"
      zone       = "ap-southeast-1a"
      Name       = "Public Subnet 1"
    },
    "pub-subnet-2" = {
      cidr_block = "10.10.2.0/24"
      zone       = "ap-southeast-1b"
      Name       = "Public Subnet 2"
    },
    "pub-subnet-3" = {
      cidr_block = "10.10.3.0/24"
      zone       = "ap-southeast-1c"
      Name       = "Public Subnet 3"
    }
  }
}

variable "private-subnet" {
  type = map(object({
    cidr_block = string
    zone       = string
    Name       = string
  }))
  default = {
    "private-subnet-1" = {
      cidr_block = "10.10.4.0/24"
      zone       = "ap-southeast-1a"
      Name       = "private Subnet 1"
    },
    "private-subnet-2" = {
      cidr_block = "10.10.5.0/24"
      zone       = "ap-southeast-1b"
      Name       = "private Subnet 2"
    },
    "private-subnet-3" = {
      cidr_block = "10.10.6.0/24"
      zone       = "ap-southeast-1c"
      Name       = "private Subnet 3"
    }
  }
}