variable "vpc_id" {
}


variable "vpc_subnets" {
}


variable "alb_sg_id" {

}

variable "alb_carsales-back-end-tg-1" {

}

variable "alb_carsales-back-end-tg-2" {

}
variable "bastion_host_sg_id" {

}
variable "cluster_id" {

}

variable "cluster_name" {

}

#variable "vpc_private_subnets" {
#
#}


variable "aws_pubic_key" {

}
variable "ecs_cluster_name" {
     default  = "carsales"
}


variable "efs_id" {

}
variable "instance_type_spot" {
    default = "t2.medium"

}

variable "max_spot_instances" {
    default = 4

}

variable "min_spot_instances" {
    default = 2

}
# Make sure your bid price is enough. 
variable "spot_bid_price"  {
    default = "0.03"

}
#variable "region" {
#    default = "ap-south-1"
#
#}


