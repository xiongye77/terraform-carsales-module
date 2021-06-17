module vpc {
source = "./modules/vpc"
}

module alb {
source = "./modules/alb"
vpc_id = module.vpc.CarSales-VPC-ID
vpc_subnets  = module.vpc.public_subnets
#certificate_arn    = module.acm.certificate_arn
}

module key {
source = "./modules/key"
}

module ecs {
source = "./modules/ecs"
}

module bastion {
source = "./modules/bastion"
aws_pubic_key = module.key.aws_pubic_key
vpc_id = module.vpc.CarSales-VPC-ID
vpc_subnets  = module.vpc.public_subnets
}

module ec2-ecs {
source = "./modules/ec2-ecs"
aws_pubic_key = module.key.aws_pubic_key
alb_sg_id = module.alb.ALB-SG
cluster_id = module.ecs.ECS-cluster-id
cluster_name = module.ecs.ECS-cluster-name
vpc_id = module.vpc.CarSales-VPC-ID
vpc_subnets  = module.vpc.private_subnets
efs_id = module.efs.efs_filesystem_id
bastion_host_sg_id = module.bastion.bastion_host_sg_id
alb_carsales-back-end-tg-1 = module.alb.alb_carsales-back-end-tg-1
alb_carsales-back-end-tg-2 = module.alb.alb_carsales-back-end-tg-2
}

module efs {
source = "./modules/efs"
vpc_id = module.vpc.CarSales-VPC-ID
vpc_subnets  = module.vpc.private_subnets
ecs_sg_id = module.ec2-ecs.ecs-sg-id
}

module rds { 
source = "./modules/rds"
vpc_id = module.vpc.CarSales-VPC-ID
vpc_subnets  = module.vpc.private_subnets
ecs_sg_id = module.ec2-ecs.ecs-sg-id
}

module route53 {
source = "./modules/route53"
alb_dns_name = module.alb.alb_dns_name
alb_dns_zone_id = module.alb.alb_dns_zone_id
}

#module acm {
#source  = "./modules/acm"
#
#domain_name  = trimsuffix(module.alb.alb_dns_name, ".")
#zone_id      = module.alb.alb_dns_zone_id
#
#}
