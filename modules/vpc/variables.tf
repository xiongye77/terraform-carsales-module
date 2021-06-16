# Define VPC Variable

variable "region" {
     default = "ap-south-1"
}

variable "aws-vpc-cidr" {
  type= string
  default="10.0.0.0/16"
}

variable "public_1_subnetCIDR" {
    default = "10.0.1.0/24"
}

variable "public_2_subnetCIDR" {
    default = "10.0.2.0/24"
}

variable "private_1_subnetCIDR" {
    default = "10.0.3.0/24"
}

variable "private_2_subnetCIDR" {
    default = "10.0.4.0/24"
}



