
git clone https://github.com/xiongye77/terraform-carsales-module.git


[ec2-user@ip-192-168-23-47 upload]$ tree
.
├── main.tf
├── modules
│   ├── acm
│   │   ├── acm.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── alb
│   │   ├── alb.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── bastion
│   │   ├── bastion-host.tf
│   │   ├── data.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ec2-ecs
│   │   ├── data.tf
│   │   ├── ecs-ec2-service.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs
│   │   ├── ecs-cluster.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── efs
│   │   ├── efs.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── key
│   │   ├── key.tf
│   │   └── outputs.tf
│   ├── rds
│   │   ├── rds.tf
│   │   └── variables.tf
│   ├── route53
│   │   ├── data.tf
│   │   ├── outputs.tf
│   │   ├── route53.tf
│   │   └── variables.tf
│   └── vpc
│       ├── data.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── vpc.tf
├── outputs.tf
├── result2.log
├── result.log

Make sure you change modules/route53/data.tf  "aconex.design" to your domain
Make sure you change modules/route53/route53.tf  "myapps-test" to what you want for ALB alias or just keep it for 

terraform init 
terraform apply -auto-approve 

the outputs.tf will include ALB DNS name and Route53 alias 
